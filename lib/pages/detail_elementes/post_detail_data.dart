import 'package:cjvm_app/model/post_entitiy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import '../../utils/color_utils.dart' as color_utils;

class PostDetailData extends StatelessWidget {
  final PostEntity post;
  const PostDetailData(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(
                PlatformIcons(context).time,
                size: 35,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Aktualisiert: ",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          DateFormat.yMMMd('de')
                              .format(DateTime.parse(post.modifiedGmt)),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            height: 3.0,
            width: MediaQuery.of(context).size.width,
            color: color_utils.commonThemeData.primaryColor,
          ),
        ),
      ],
    );
  }
}
