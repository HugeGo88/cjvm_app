import 'package:cjvm_app/widgets/event_list.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../utils/color_utils.dart' as color_utils;

class EventsTab extends StatefulWidget {
  const EventsTab({super.key});

  @override
  State<EventsTab> createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  DateTime today = DateTime.now();
  //DateTime _selectedDay = DateTime.now();
  //DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          focusedDay: today,
          startingDayOfWeek: StartingDayOfWeek.monday,
          locale: "de_DE",
          weekNumbersVisible: true,
          //rowHeight: 35,
          //TODO do something with selected date
/*           selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(
              () {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update `_focusedDay` here as well
              },
            );
          }, */
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
                color: color_utils.commonThemeData.primaryColor,
                shape: BoxShape.circle),
            isTodayHighlighted: true,
          ),
          availableGestures: AvailableGestures.all,
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(const Duration(days: 365 * 3)),
          headerStyle: const HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
          ),
        ),
        const Expanded(
          child: Center(
            child: EventList(),
          ),
        ),
      ],
    );
  }
}
