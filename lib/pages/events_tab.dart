import 'package:cjvm_app/widgets/event_list.dart';
import 'package:flutter/material.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({super.key});

  @override
  State<EventsTab> createState() => _EventsTabState();
}

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

class _EventsTabState extends State<EventsTab> {
  DateTime today = DateTime.now();
  late final DateTime _selectedDay = DateTime.now();
  late final DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // TableCalendar(
        //   focusedDay: _focusedDay,
        //   startingDayOfWeek: StartingDayOfWeek.monday,
        //   locale: "de_DE",
        //   weekNumbersVisible: true,
        //   onPageChanged: (focusedDay) {
        //     _selectedDay = _focusedDay;
        //     _focusedDay = focusedDay;
        //   },
        //   eventLoader: (day) {
        //     if (day.weekday == DateTime.sunday) {
        //       return [const Event('Test')];
        //     } else {
        //       return [];
        //     }
        //   },
        //   rowHeight: 35,
        //   //TODO do something with selected date
        //   selectedDayPredicate: (day) {
        //     return isSameDay(_selectedDay, day);
        //   },
        //   onDaySelected: (selectedDay, focusedDay) {
        //     setState(() {
        //       _selectedDay = selectedDay;
        //       _focusedDay = focusedDay; // update `_focusedDay` here as well
        //     });
        //   },
        //   calendarStyle: CalendarStyle(
        //     markerDecoration:
        //         BoxDecoration(color: color_utils.commonThemeData.primaryColor),
        //     todayDecoration: BoxDecoration(
        //         color: color_utils.commonThemeData.primaryColor,
        //         shape: BoxShape.circle),
        //     selectedDecoration:
        //         const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
        //     isTodayHighlighted: true,
        //   ),
        //   availableGestures: AvailableGestures.all,
        //   firstDay: DateTime.now(),
        //   lastDay: DateTime.now().add(const Duration(days: 365 * 3)),
        //   headerStyle: const HeaderStyle(
        //     titleCentered: true,
        //     formatButtonVisible: false,
        //   ),
        // ),
        Expanded(
          child: Center(
            child: EventList(),
          ),
        ),
      ],
    );
  }
}
