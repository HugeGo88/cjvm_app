import 'package:cjvm_app/model/post_entitiy.dart';
import 'package:cjvm_app/utils/constants.dart';
import 'package:flutter/material.dart';

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
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: SizedBox(
                width: listHeight,
                height: listHeight,
                child: Placeholder(),
              ),
            ),
            Flexible(
                child: SizedBox(
              width: listHeight,
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
