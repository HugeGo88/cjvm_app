import 'dart:io';

import 'package:cjvm_app/model/post_entitiy.dart';
import 'package:cjvm_app/widgets/post_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class PostListDetail extends StatelessWidget {
  final PostEntity post;
  const PostListDetail(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PlatformScaffold(
      iosContentPadding: true,
      appBar: PlatformAppBar(
        title: Text(
          post.title,
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: post.image,
                child: Placeholder(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Placeholder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
