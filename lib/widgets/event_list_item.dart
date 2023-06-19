import 'package:cjvm_app/model/event_entitiy.dart';
import 'package:cjvm_app/utils/constants.dart';
import 'package:cjvm_app/widgets/cached_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../pages/event_detail.dart';
import '../utils/color_utils.dart' as color_utils;

class EventListItem extends StatelessWidget {
  final EventEntity event;
  const EventListItem({required this.event, super.key});

  String allDayVenue(DateTime start, DateTime end) {
    if (start.day != end.day) {
      return "${DateFormat.Md('de').format(start)} bis ${DateFormat.yMd('de').format(end)}";
    } else {
      return DateFormat.yMd('de').format(start);
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('de', null);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
            context,
            platformPageRoute(
                builder: (context) => EventDetail(event), context: context));
      },
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CachedImage(
                    url: event.image,
                    height: listHeight,
                    width: listWidth,
                    fit: BoxFit.cover),
              ),
              Expanded(
                child: SizedBox(
                  height: listHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          event.title,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.apply(fontWeightDelta: 1),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Row(
                        children: [
                          event.venue != ""
                              ? const Padding(
                                  padding: EdgeInsets.only(right: 4),
                                  child: Icon(
                                    CupertinoIcons.map_pin_ellipse,
                                    size: 15,
                                  ),
                                )
                              : Container(),
                          Text(
                            event.venue != "" ? event.venue : '',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Icon(
                              PlatformIcons(context).time,
                              size: 15,
                            ),
                          ),
                          Text(
                            event.allDay
                                ? allDayVenue(event.startDate, event.endDate)
                                : "${DateFormat.Hm('de').format(event.startDate)}Uhr bis ${DateFormat.Hm('de').format(event.endDate)}Uhr",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Column(
                  children: <Widget>[
                    Text(
                      "${event.startDate.day}",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      DateFormat.MMM('de')
                          .format(event.startDate)
                          .toUpperCase(),
                      style: Theme.of(context).textTheme.titleMedium?.apply(
                          fontWeightDelta: 3,
                          color: color_utils.commonThemeData.primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
