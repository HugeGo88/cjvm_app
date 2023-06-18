import 'package:cjvm_app/widgets/event_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({super.key});

  @override
  State<EventsTab> createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          focusedDay: today,
          startingDayOfWeek: StartingDayOfWeek.monday,
          locale: "de_DE",
          weekNumbersVisible: true,
          rowHeight: 35,
          availableGestures: AvailableGestures.all,
          firstDay: DateTime.utc(2023, 1, 1),
          lastDay: DateTime.utc(2030, 1, 1),
          headerStyle: const HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
          ),
        ),
        const EventList(),
      ],
    );
  }
}
