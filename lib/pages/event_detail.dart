import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../model/cached_image.dart';
import '../model/event_entitiy.dart';
import 'detail_elementes/event_detail_data.dart';
import 'detail_elementes/html_content.dart';

class EventDetail extends StatelessWidget {
  final EventEntity event;
  const EventDetail(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    initializeDateFormatting();
    return PlatformScaffold(
      iosContentPadding: true,
      appBar: PlatformAppBar(
        title: Text(
          event.title,
        ),
      ),
      body: SafeArea(
        top: false,
        child: OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Hero(
                          tag: event.image,
                          child: CachedImage(
                            event.image,
                            width: size.width,
                          ),
                        ),
                        EventDetailData(event),
                        HtmlContent(event.description),
                      ],
                    ),
                  )
                : Row(
                    children: <Widget>[
                      SizedBox(
                        width: size.width / 3,
                        child: Column(
                          children: <Widget>[
                            Hero(
                              tag: event.image,
                              child: CachedImage(
                                event.image,
                                width: size.width,
                              ),
                            ),
                            EventDetailData(event),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minWidth: MediaQuery.of(context).size.width,
                                minHeight: MediaQuery.of(context).size.height),
                            child: IntrinsicHeight(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  HtmlContent(event.description),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
