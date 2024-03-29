import 'package:cjvm_app/model/ticket_entitiy.dart';
import 'package:cjvm_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../model/event_entitiy.dart';
import '../network/wp_api.dart';
import 'event_list_item.dart';
import '../utils/color_utils.dart' as color_utils;

class EventList extends StatefulWidget {
  final int maxEvents;
  const EventList({this.maxEvents = 100, super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  List<EventEntity> allEvents = <EventEntity>[];
  List<TicketEntity> allTickets = <TicketEntity>[];

  int page = 0;
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  void getData() {
    if (!isLoading) {
      setState(
        () {
          page++;
          isLoading = true;
        },
      );

      WpApi.getTicketList(page: page).then(
        (tickets) {
          setState(
            () {
              isLoading = false;
              allTickets.addAll(tickets);
            },
          );
        },
      );

      WpApi.getEventList(page: page).then(
        (events) {
          setState(
            () {
              isLoading = false;
              allEvents.addAll(events);
            },
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          getData();
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (var event in allEvents) {
      for (var ticket in allTickets) {
        if (ticket.eventId == event.id.toString()) {
          event.ticket = ticket;
        }
      }
    }
    return ListView.separated(
      itemBuilder: eventTile,
      separatorBuilder: (context, index) => Container(
        height: 1,
        color: color_utils.commonThemeData.primaryColor,
      ),
      itemCount: allEvents.length + 1 < widget.maxEvents
          ? allEvents.length + 1
          : widget.maxEvents,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
    );
  }

  Widget eventTile(BuildContext context, int index) {
    if (index == allEvents.length) {
      return _buildProgressIndicator();
    } else {
      return EventListItem(event: allEvents[index]);
    }
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(edgePadding),
      child: Center(
        child: Visibility(
          visible: isLoading,
          child: PlatformCircularProgressIndicator(),
        ),
      ),
    );
  }
}
