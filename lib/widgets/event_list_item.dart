import 'package:cjvm_app/model/event_entitiy.dart';
import 'package:cjvm_app/utils/constants.dart';
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
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: listHeight),
        child: Padding(
          padding: const EdgeInsets.all(edgePadding),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.apply(fontWeightDelta: 1),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: contentPadding),
                          child: Icon(
                            PlatformIcons(context).time,
                            size: iconSize,
                          ),
                        ),
                        Text(
                          event.allDay
                              ? allDayVenue(event.startDate, event.endDate)
                              : "${DateFormat.Hm('de').format(event.startDate)} Uhr bis ${DateFormat.Hm('de').format(event.endDate)} Uhr",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    event.venue != ""
                        ? Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: contentPadding),
                                child: Icon(
                                  CupertinoIcons.map_pin_ellipse,
                                  size: iconSize,
                                ),
                              ),
                              Text(
                                event.venue,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          )
                        : Container(),
                    event.ticket != null
                        ? Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: contentPadding),
                                child: Icon(
                                  CupertinoIcons.ticket,
                                  size: iconSize,
                                ),
                              ),
                              if (event.ticket!.stock != "-1")
                                Text("${event.ticket!.stock} Plätze übrig")
                              else
                                const Text("Plätze übrig")
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: contentPadding),
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
          ),
        ),
      ),
    );
  }
}
