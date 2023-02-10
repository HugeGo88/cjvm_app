import 'package:cjvm_app/model/cached_image.dart';
import 'package:cjvm_app/model/post_entitiy.dart';
import 'package:cjvm_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../pages/post_detail.dart';

class PostListItem extends StatelessWidget {
  final PostEntity post;

  const PostListItem(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
            context,
            platformPageRoute(
                builder: (context) => PostDetail(post), context: context));
      },
      child: Column(children: [
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CachedImage(
                post.image,
                height: listHeight,
                width: listHeight,
                fit: BoxFit.cover,
              ),
            ),
            Flexible(
                child: SizedBox(
              height: listHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      post.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  )
                ],
              ),
            ))
          ],
        )
      ]),
    );
  }
}
