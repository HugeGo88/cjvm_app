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
        Padding(
          padding: const EdgeInsets.all(edgePadding),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: contentPadding, right: contentPadding),
                child: Icon(
                  PlatformIcons(context).time,
                  size: 20,
                ),
              ),
              Text(
                DateFormat.yMMMd('de').format(DateTime.parse(post.modifiedGmt)),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: edgePadding, right: contentPadding),
                child: Icon(
                  PlatformIcons(context).folderOpen,
                  size: 20,
                ),
              ),
              Flexible(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  post.extra.categories!
                      .map((category) => category.name)
                      .join(', '),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
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
