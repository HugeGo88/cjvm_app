import 'package:cjvm_app/model/event_entitiy.dart';
import 'package:cjvm_app/network/wp_api.dart';
import 'package:cjvm_app/widgets/event_list_item.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class EventCalendar extends StatefulWidget {
  const EventCalendar({super.key});

  @override
  State<EventCalendar> createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  List<EventEntity> allEvents = [];
  Map<DateTime, List<EventEntity>> eventsMap = {};
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool isLoading = false;
  bool _showCalendar = false;
  final Set<String> _loadedMonths = {};
  final ScrollController _listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _fetchEventsForMonth(_focusedDay);
    // controller kept for potential programmatic scroll, use NotificationListener for detection
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    super.dispose();
  }

  DateTime _parseMonthKey(String key) {
    final parts = key.split('-');
    final y = int.tryParse(parts[0]) ?? DateTime.now().year;
    final m = int.tryParse(parts[1]) ?? DateTime.now().month;
    return DateTime(y, m, 1);
  }

  void _fetchNextMonth() {
    if (_loadedMonths.isEmpty) {
      _fetchEventsForMonth(_focusedDay);
      return;
    }
    // find last loaded month
    DateTime maxMonth = _loadedMonths.map(_parseMonthKey).reduce((a, b) {
      return (a.year * 12 + a.month) >= (b.year * 12 + b.month) ? a : b;
    });
    final nextMonth = DateTime(maxMonth.year, maxMonth.month + 1, 1);
    _fetchEventsForMonth(nextMonth);
  }

  Future<void> _fetchEventsForMonth(DateTime focused) async {
    final key = '${focused.year}-${focused.month.toString().padLeft(2, '0')}';
    if (_loadedMonths.contains(key) || isLoading) return;
    setState(() {
      isLoading = true;
    });

    final start = DateTime(focused.year, focused.month, 1);
    final end = DateTime(focused.year, focused.month + 1, 1)
        .subtract(const Duration(days: 1));

    List<EventEntity> events =
        await WpApi.getEventListByRange(start: start, end: end);

    // merge into eventsMap; for multi-day events add an entry for each day in the event range (clamped to the month)
    final newMap = Map<DateTime, List<EventEntity>>.from(eventsMap);
    for (var e in events) {
      // determine overlap between the event range and the requested month range
      DateTime evStart =
          DateTime(e.startDate.year, e.startDate.month, e.startDate.day);
      DateTime evEnd = DateTime(e.endDate.year, e.endDate.month, e.endDate.day);
      DateTime addFrom = evStart.isBefore(start) ? start : evStart;
      DateTime addTo = evEnd.isAfter(end) ? end : evEnd;
      for (DateTime d = addFrom;
          !d.isAfter(addTo);
          d = d.add(const Duration(days: 1))) {
        final day = DateTime(d.year, d.month, d.day);
        final list = newMap.putIfAbsent(day, () => []);
        if (!list.any((x) => x.id == e.id)) list.add(e);
      }
    }

    // merge unique events into allEvents by id
    final existingIds = allEvents.map((e) => e.id).toSet();
    for (var e in events) {
      if (!existingIds.contains(e.id)) {
        allEvents.add(e);
        existingIds.add(e.id);
      }
    }

    setState(() {
      eventsMap = newMap;
      _loadedMonths.add(key);
      isLoading = false;
    });
  }

  List<EventEntity> _eventsForDay(DateTime day) {
    final key = DateTime(day.year, day.month, day.day);
    return eventsMap[key] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Row(
            children: [
              Text(
                '',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              IconButton(
                tooltip:
                    _showCalendar ? 'Kalender ausblenden' : 'Kalender anzeigen',
                onPressed: () {
                  final newShow = !_showCalendar;
                  setState(() => _showCalendar = newShow);
                  if (!newShow) {
                    // ensure focused month is loaded when hiding calendar
                    _fetchEventsForMonth(_focusedDay);
                  }
                },
                icon: Icon(
                    _showCalendar ? Icons.calendar_today : Icons.view_list),
              ),
            ],
          ),
        ),
        if (_showCalendar)
          Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: TableCalendar<EventEntity>(
                firstDay: DateTime.now().subtract(const Duration(days: 365)),
                lastDay: DateTime.now().add(const Duration(days: 365 * 2)),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  if (_selectedDay == null) return false;
                  return isSameDay(_selectedDay!, day);
                },
                eventLoader: _eventsForDay,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onPageChanged: (focusedDay) {
                  // lazy load events for the visible month
                  _focusedDay = focusedDay;
                  _fetchEventsForMonth(focusedDay);
                },
                calendarStyle: const CalendarStyle(),
                calendarBuilders: CalendarBuilders<EventEntity>(
                  markerBuilder: (context, date, events) {
                    if (events.isEmpty) return const SizedBox.shrink();
                    // show up to 3 colored dots corresponding to categories
                    final dots = events
                        .map((e) => _colorForEvent(e))
                        .toSet()
                        .take(3)
                        .map((c) => Container(
                              width: 8,
                              height: 8,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 1.5),
                              decoration: BoxDecoration(
                                  color: c, shape: BoxShape.circle),
                            ))
                        .toList();

                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: dots,
                    );
                  },
                ),
                headerStyle: const HeaderStyle(
                    formatButtonVisible: false, titleCentered: true),
              ),
            ),
          ),
        Expanded(
          child: _buildEventListForSelectedDay(),
        ),
      ],
    );
  }

  Widget _buildEventListForSelectedDay() {
    List<EventEntity> events;
    if (!_showCalendar) {
      // show all loaded events (across loaded months)
      events = List<EventEntity>.from(allEvents);
      events.sort((a, b) => a.startDate.compareTo(b.startDate));
    } else {
      events = _selectedDay == null ? [] : _eventsForDay(_selectedDay!);
    }
    if (events.isEmpty) {
      return const Center(
        child: Text('Keine Termine an diesem Tag.'),
      );
    }

    if (!_showCalendar) {
      // show combined month list with lazy-loading bottom indicator
      final sorted = List<EventEntity>.from(events);
      final itemCount = sorted.length + (isLoading ? 1 : 0);
      return NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification.metrics.pixels >=
                  scrollNotification.metrics.maxScrollExtent - 200 &&
              !isLoading) {
            _fetchNextMonth();
          }
          return false;
        },
        child: ListView.separated(
          controller: _listScrollController,
          itemCount: itemCount,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            if (index >= sorted.length) {
              return const Padding(
                padding: EdgeInsets.all(12.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return EventListItem(event: sorted[index]);
          },
        ),
      );
    }

    return ListView.separated(
      itemCount: events.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) => EventListItem(event: events[index]),
    );
  }

  Color _colorForEvent(EventEntity e) {
    String? cat = e.categories.isNotEmpty ? e.categories.first : null;
    if (cat != null && cat.isNotEmpty) {
      final mapping = <String, Color>{
        'Konzerte': Colors.red,
        'Gottesdienst': Colors.green,
        'Jugend': Colors.orange,
        'Familie': Colors.purple,
      };
      if (mapping.containsKey(cat)) return mapping[cat]!;
      // fallback: pick a color from Material primaries based on hash
      final idx = cat.hashCode.abs() % Colors.primaries.length;
      return Colors.primaries[idx];
    }
    return Colors.blueAccent;
  }
}
