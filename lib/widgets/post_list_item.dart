import 'package:cjvm_app/model/post_entitiy.dart';
import 'package:cjvm_app/utils/constants.dart';
import 'package:cjvm_app/widgets/post_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PostListItem extends StatelessWidget {
  final PostEntity post;

  const PostListItem(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: Column(children: [
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: const SizedBox(
                width: LIST_HIGHT,
                height: LIST_HIGHT,
                child: Placeholder(),
              ),
            ),
            Flexible(
                child: SizedBox(
              width: LIST_HIGHT,
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
