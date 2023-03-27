import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import '../utils/color_utils.dart' as color_utils;

import '../model/cached_image.dart';
import '../model/event_entitiy.dart';

class EventDetail extends StatelessWidget {
  final EventEntity event;
  const EventDetail(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool venueSet = event.venue == null ? false : true;
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait
            ? PlatformScaffold(
                iosContentPadding: true,
                appBar: PlatformAppBar(
                  title: Text(
                    event.title,
                  ),
                ),
                body: SafeArea(
                  top: false,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Hero(
                          tag: event.image,
                          child: CachedImage(
                            event.image,
                            width: size.width,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              if (venueSet)
                                Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.map_pin_ellipse,
                                      size: 35,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            event.venue,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          Text(
                                            event.address,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              Container(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    PlatformIcons(context).time,
                                    size: 35,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          event.allDay
                                              ? "${DateFormat.MEd('de').format(event.startDate)} bis ${DateFormat.MEd('de').format(event.endDate)}"
                                              : DateFormat.MMMMEEEEd('de')
                                                  .format(event.startDate),
                                        ),
                                        Text(
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          event.allDay
                                              ? ""
                                              : "${DateFormat.Hm('de').format(event.startDate)}Uhr bis ${DateFormat.Hm('de').format(event.endDate)}Uhr",
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            height: 3.0,
                            width: MediaQuery.of(context).size.width,
                            color: color_utils.commonThemeData.primaryColor,
                          ),
                        ),
                        Html(
                          data: event.description,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : PlatformScaffold(
                iosContentPadding: true,
                appBar: PlatformAppBar(
                  title: Text(
                    event.title,
                  ),
                ),
                body: SafeArea(
                  top: false,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: size.width / 3,
                        child: Column(
                          children: [
                            Hero(
                              tag: event.image,
                              child: CachedImage(
                                event.image,
                                width: size.width,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  if (venueSet)
                                    Row(
                                      children: [
                                        const Icon(
                                          CupertinoIcons.map_pin_ellipse,
                                          size: 35,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                event.venue,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Text(
                                                event.address,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  Container(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        PlatformIcons(context).time,
                                        size: 35,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                              (event.allDay &&
                                                      event.startDate.day !=
                                                          event.endDate.day)
                                                  ? "${DateFormat.MEd('de').format(event.startDate)} bis ${DateFormat.yMEd('de').format(event.endDate)}"
                                                  : DateFormat.yMMMMEEEEd('de')
                                                      .format(event.startDate),
                                            ),
                                            Text(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                              event.allDay
                                                  ? ""
                                                  : "${DateFormat.Hm('de').format(event.startDate)}Uhr bis ${DateFormat.Hm('de').format(event.endDate)}Uhr",
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Container(
                                height: 3.0,
                                width: MediaQuery.of(context).size.width,
                                color: color_utils.commonThemeData.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Html(
                            data: event.description,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
