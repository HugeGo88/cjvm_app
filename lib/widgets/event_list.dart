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
  List<EventEntity> events = <EventEntity>[];

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

      WpApi.getEventList(page: page).then(
        (events) {
          setState(
            () {
              isLoading = false;
              events.addAll(events);
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
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: eventTile,
      separatorBuilder: (context, index) => Container(
        height: 1,
        color: color_utils.commonThemeData.primaryColor,
      ),
      itemCount: events.length + 1 < widget.maxEvents
          ? events.length + 1
          : widget.maxEvents,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
    );
  }

  Widget eventTile(BuildContext context, int index) {
    if (index == events.length) {
      return _buildProgressIndicator();
    } else {
      return EventListItem(event: events[index]);
    }
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Visibility(
          visible: isLoading,
          child: PlatformCircularProgressIndicator(),
        ),
      ),
    );
  }
}
