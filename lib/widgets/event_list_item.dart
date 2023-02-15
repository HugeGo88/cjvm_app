import 'package:cjvm_app/model/event_entitiy.dart';
import 'package:cjvm_app/utils/constants.dart';
import 'package:cjvm_app/widgets/cached_image.dart';
import 'package:flutter/material.dart';

class EventListItem extends StatelessWidget {
  final EventEntity event;
  const EventListItem({required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CachedImage(
                    url: event.image,
                    height: listHeight,
                    width: listHeight,
                    fit: BoxFit.cover),
              )
            ],
          )
        ],
      ),
    );
  }
}
