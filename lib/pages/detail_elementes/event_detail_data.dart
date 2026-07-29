import 'package:cjvm_app/model/event_entitiy.dart';
import 'package:cjvm_app/utils/constants.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/color_utils.dart' as color_utils;

class EventDetailData extends StatefulWidget {
  final EventEntity event;
  const EventDetailData(this.event, {super.key});

  @override
  State<EventDetailData> createState() => _EventDetailDataState();
}

class _EventDetailDataState extends State<EventDetailData> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  String _formatCalendarDate(DateTime dateTime) {
    return DateFormat("yyyyMMdd'T'HHmmss'Z'").format(dateTime.toUtc());
  }

  Uri _googleCalendarEventUrl() {
    final DateTime startDate = widget.event.startDate;
    final DateTime endDate = widget.event.endDate;
    final String dates;

    if (widget.event.allDay) {
      final String start = DateFormat('yyyyMMdd').format(startDate);
      final String endExclusive =
          DateFormat('yyyyMMdd').format(endDate.add(const Duration(days: 1)));
      dates = '$start/$endExclusive';
    } else {
      dates = '${_formatCalendarDate(startDate)}/${_formatCalendarDate(endDate)}';
    }

    return Uri.https('calendar.google.com', '/calendar/render', {
      'action': 'TEMPLATE',
      'text': widget.event.title,
      'details': widget.event.description,
      'location': widget.event.address,
      'dates': dates,
    });
  }

  String allDayVenue(DateTime start, DateTime end) {
    if (start.day != end.day) {
      return "${DateFormat.Md('de').format(start)} bis ${DateFormat.yMd('de').format(end)}";
    } else {
      return DateFormat.yMd('de').format(start);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool venueSet = widget.event.venue == "" ? false : true;
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: edgePadding, right: contentPadding),
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
                    widget.event.allDay
                        ? allDayVenue(
                            widget.event.startDate, widget.event.endDate)
                        : DateFormat.MMMMEEEEd('de')
                            .format(widget.event.startDate),
                  ),
                  if (!widget.event.allDay)
                    Text(
                      style: Theme.of(context).textTheme.bodyMedium,
                      "${DateFormat.Hm('de').format(widget.event.startDate)} Uhr bis ${DateFormat.Hm('de').format(widget.event.endDate)} Uhr",
                    ),
                ],
              ),
            ),
            PlatformIconButton(
              materialIcon: const Icon(Icons.edit_calendar_outlined),
              cupertinoIcon: const Icon(CupertinoIcons.calendar_badge_plus),
              onPressed: () async {
                await analytics.logEvent(
                  name: "button_tracked",
                  parameters: {
                    "button_name": "AddCalendar",
                  },
                );
                await _launchInBrowser(_googleCalendarEventUrl());
              },
            ),
          ],
        ),
        if (venueSet)
          Row(
            children: [
              const Padding(
                padding:
                    EdgeInsets.only(left: edgePadding, right: contentPadding),
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
                      widget.event.venue,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      widget.event.address,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              PlatformIconButton(
                cupertinoIcon: const Icon(CupertinoIcons.map),
                materialIcon: const Icon(Icons.map_outlined),
                onPressed: () async {
                  await analytics.logEvent(
                    name: "button_tracked",
                    parameters: {
                      "button_name": "OpenMap",
                    },
                  );
                  await _launchInBrowser(
                    Uri.https(
                      'www.google.com',
                      '/maps/search/',
                      {
                        'api': '1',
                        'query': widget.event.address,
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        if (widget.event.ticket != null)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.event.ticket?.capacity != "-1")
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: edgePadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Anmeldung erforderlich",
                        style: Theme.of(context).textTheme.titleMedium?.apply(
                            color: color_utils.commonThemeData.primaryColor),
                      ),
                      if (DateTime.now()
                          .isBefore(widget.event.ticket!.startDate))
                        Text(
                          "Buchungsfreischaltung ab ${DateFormat.yMd('DE').add_jm().format(widget.event.ticket!.startDate)} Uhr",
                          style: Theme.of(context).textTheme.titleMedium?.apply(
                              color: color_utils.commonThemeData.primaryColor),
                        ),
                    ],
                  ),
                ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        left: edgePadding, right: contentPadding),
                    child: Icon(
                      CupertinoIcons.ticket,
                      size: iconSizeBig,
                    ),
                  ),
                  if (widget.event.ticket!.stock != "-1")
                    Expanded(
                      child: Text(
                        style: Theme.of(context).textTheme.bodyMedium,
                        "${widget.event.ticket!.stock} Plätze übrig",
                      ),
                    )
                  else
                    Expanded(
                      child: Text(
                        style: Theme.of(context).textTheme.bodyMedium,
                        "Plätze übrig",
                      ),
                    ),
                  if (DateTime.now().isAfter(widget.event.ticket!.startDate))
                    PlatformIconButton(
                      icon: Icon(
                        PlatformIcons(context).add,
                      ),
                      onPressed: () async {
                        await analytics.logEvent(
                          name: "button_tracked",
                          parameters: {
                            "button_name": "AddTicket",
                          },
                        );
                        _launchInBrowser(
                          Uri.parse("${widget.event.url}/#rsvp-now"),
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
