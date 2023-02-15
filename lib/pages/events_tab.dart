import 'package:cjvm_app/widgets/event_list.dart';
import 'package:flutter/cupertino.dart';

class EventsTab extends StatelessWidget {
  const EventsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: EventList(),
    );
  }
}
