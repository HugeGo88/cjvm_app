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
  bool _showCalendar = true;
  final Set<String> _loadedMonths = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _fetchEventsForMonth(_focusedDay);
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

    // merge into eventsMap
    final newMap = Map<DateTime, List<EventEntity>>.from(eventsMap);
    for (var e in events) {
      final day =
          DateTime(e.startDate.year, e.startDate.month, e.startDate.day);
      final list = newMap.putIfAbsent(day, () => []);
      // avoid duplicates by id
      if (!list.any((x) => x.id == e.id)) list.add(e);
    }

    setState(() {
      allEvents.addAll(events);
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
                'Termine',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              IconButton(
                tooltip:
                    _showCalendar ? 'Kalender ausblenden' : 'Kalender anzeigen',
                onPressed: () => setState(() => _showCalendar = !_showCalendar),
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
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildEventListForSelectedDay(),
        ),
      ],
    );
  }

  Widget _buildEventListForSelectedDay() {
    List<EventEntity> events;
    if (!_showCalendar) {
      // show events for focused month (or all loaded events if none)
      events = allEvents
          .where((e) =>
              e.startDate.year == _focusedDay.year &&
              e.startDate.month == _focusedDay.month)
          .toList();
      events.sort((a, b) => a.startDate.compareTo(b.startDate));
    } else {
      events = _selectedDay == null ? [] : _eventsForDay(_selectedDay!);
    }
    if (events.isEmpty) {
      return const Center(
        child: Text('Keine Termine an diesem Tag.'),
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
