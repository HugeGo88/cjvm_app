import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../model/cached_image.dart';
import '../model/post_entitiy.dart';

class PostDetail extends StatelessWidget {
  final PostEntity post;

  const PostDetail(this.post, {super.key});

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
                child: CachedImage(
                  post.image,
                  width: size.width,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Html(
                  data: post.content,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
