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

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });

    List<EventEntity> events = [];
    // fetch first 3 pages to populate calendar; adjust as needed
    for (int page = 1; page <= 3; page++) {
      final pageEvents = await WpApi.getEventList(page: page);
      if (pageEvents.isEmpty) break;
      events.addAll(pageEvents);
    }

    final map = <DateTime, List<EventEntity>>{};
    for (var e in events) {
      final day =
          DateTime(e.startDate.year, e.startDate.month, e.startDate.day);
      map.putIfAbsent(day, () => []).add(e);
    }

    setState(() {
      allEvents = events;
      eventsMap = map;
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
        Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
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
                            margin: const EdgeInsets.symmetric(horizontal: 1.5),
                            decoration:
                                BoxDecoration(color: c, shape: BoxShape.circle),
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
    final events = _selectedDay == null ? [] : _eventsForDay(_selectedDay!);
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
