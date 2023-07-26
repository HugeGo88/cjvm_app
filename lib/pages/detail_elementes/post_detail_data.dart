import 'package:cjvm_app/model/post_entitiy.dart';
import 'package:cjvm_app/utils/constants.dart';
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
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(edgePadding),
              child: Icon(
                PlatformIcons(context).time,
                size: 20,
              ),
            ),
            Column(
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
