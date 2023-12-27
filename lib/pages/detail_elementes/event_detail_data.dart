import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cjvm_app/model/event_entitiy.dart';
import 'package:cjvm_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/color_utils.dart' as color_utils;

class EventDetailData extends StatelessWidget {
  final EventEntity event;
  const EventDetailData(this.event, {super.key});

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

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
      iosParams: IOSParams(
        reminder: const Duration(minutes: 60),
        url: event.url,
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
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(edgePadding),
              child: Icon(
                PlatformIcons(context).time,
                size: iconSizeBig,
              ),
            ),
            Expanded(
              child: Column(
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
              ),
            ),
            PlatformIconButton(
              materialIcon: const Icon(Icons.edit_calendar_outlined),
              cupertinoIcon: const Icon(CupertinoIcons.calendar_badge_plus),
              onPressed: () {
                Add2Calendar.addEvent2Cal(
                  buildEvent(),
                );
              },
            ),
          ],
        ),
        if (venueSet)
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(edgePadding),
                child: Icon(
                  CupertinoIcons.map_pin_ellipse,
                  size: iconSizeBig,
                ),
              ),
              Expanded(
                child: Column(
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
                ),
              ),
              PlatformIconButton(
                cupertinoIcon: const Icon(CupertinoIcons.map),
                materialIcon: const Icon(Icons.map_outlined),
                onPressed: () => MapsLauncher.launchQuery(event.address),
              ),
            ],
          ),
        if (event.ticket != null)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (event.ticket?.capacity != "-1")
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: edgePadding),
                  child: Text(
                    "Anmeldung erforderlich",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(edgePadding),
                    child: Icon(
                      CupertinoIcons.ticket,
                      size: iconSizeBig,
                    ),
                  ),
                  if (event.ticket!.stock != "-1")
                    Expanded(
                      child: Text(
                        style: Theme.of(context).textTheme.bodyMedium,
                        "${event.ticket!.stock} Plätze übrig",
                      ),
                    )
                  else
                    Expanded(
                      child: Text(
                        style: Theme.of(context).textTheme.bodyMedium,
                        "Plätze übrig",
                      ),
                    ),
                  PlatformIconButton(
                    icon: Icon(
                      PlatformIcons(context).add,
                    ),
                    onPressed: () {
                      _launchInBrowser(
                        Uri.parse("${event.url}/#rsvp-now"),
                      );
                    },
                  ),
                ],
              ),
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
