import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cjvm_app/model/event_entitiy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import '../../utils/color_utils.dart' as color_utils;

class EventDetailData extends StatelessWidget {
  final EventEntity event;
  const EventDetailData(this.event, {super.key});

  String allDayVenue(DateTime start, DateTime end) {
    if (start.day != end.day) {
      return "${DateFormat.Md('de').format(start)} bis ${DateFormat.yMd('de').format(end)}";
    } else {
      return DateFormat.yMd('de').format(start);
    }
  }

  Event buildEvent({Recurrence? recurrence}) {
    return Event(
      title: event.title,
      description: event.description,
      location: event.address,
      startDate: event.startDate,
      endDate: event.endDate,
      allDay: event.allDay,
      iosParams: const IOSParams(
        reminder: Duration(minutes: 60),
        url: "http://cvjm-walheim.de",
      ),
      androidParams: const AndroidParams(
        emailInvites: [],
      ),
      recurrence: recurrence,
    );
  }

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
        if (venueSet)
          PlatformTextButton(
            child: const Text("In Karte anzeigen"),
            onPressed: () =>
                MapsLauncher.launchQuery("${event.address} ${event.venue}"),
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
                      ? allDayVenue(event.startDate, event.endDate)
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
        PlatformTextButton(
          child: const Text("Zu Kalender hinzufügen"),
          onPressed: () {
            Add2Calendar.addEvent2Cal(
              buildEvent(),
            );
          },
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
