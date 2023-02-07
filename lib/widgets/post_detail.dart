import 'package:cjvm_app/model/post_entitiy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
                child: const Placeholder(),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Placeholder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
