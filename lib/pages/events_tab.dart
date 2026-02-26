import 'package:cjvm_app/widgets/event_calendar.dart';
import 'package:flutter/material.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({super.key});

  @override
  State<EventsTab> createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: EventCalendar(),
    );
  }
}
