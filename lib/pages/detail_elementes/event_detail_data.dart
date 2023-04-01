import 'package:cjvm_app/model/event_entitiy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import '../../utils/color_utils.dart' as color_utils;

class EventDetailData extends StatelessWidget {
  final EventEntity event;
  const EventDetailData(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    bool venueSet = event.venue == "" ? false : true;
    return Column(
      children: [
        if (venueSet)
          Row(
            children: [
              const Icon(
                CupertinoIcons.map_pin_ellipse,
                size: 35,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.venue,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    event.address,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              )
            ],
          ),
        Row(
          children: [
            Icon(
              PlatformIcons(context).time,
              size: 35,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  style: Theme.of(context).textTheme.bodyMedium,
                  event.allDay
                      ? "${DateFormat.MEd('de').format(event.startDate)} bis ${DateFormat.MEd('de').format(event.endDate)}"
                      : DateFormat.MMMMEEEEd('de').format(event.startDate),
                ),
                if (!event.allDay)
                  Text(
                    style: Theme.of(context).textTheme.bodyMedium,
                    "${DateFormat.Hm('de').format(event.startDate)}Uhr bis ${DateFormat.Hm('de').format(event.endDate)}Uhr",
                  ),
              ],
            )
          ],
        ),
        Container(
          height: 3.0,
          width: MediaQuery.of(context).size.width,
          color: color_utils.commonThemeData.primaryColor,
        ),
      ],
    );
  }
}
