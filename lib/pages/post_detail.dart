import 'package:cjvm_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:share_plus/share_plus.dart';

import '../model/cached_image.dart';
import '../model/post_entitiy.dart';
import 'detail_elementes/html_content.dart';
import 'detail_elementes/post_detail_data.dart';

class PostDetail extends StatelessWidget {
  final PostEntity post;

  const PostDetail(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller1 = ScrollController();
    final controller2 = ScrollController();
    Size size = MediaQuery.of(context).size;
    initializeDateFormatting();
    return PlatformScaffold(
      iosContentPadding: true,
      appBar: PlatformAppBar(
        title: Text(
          post.title,
        ),
        trailingActions: [
          PlatformIconButton(
            icon: Icon(PlatformIcons(context).share),
            onPressed: () {
              Share.share(post.link, subject: post.title);
            },
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Hero(
                          tag: post.image,
                          child: CachedImage(
                            post.image,
                            width: size.width,
                          ),
                        ),
                        PostDetailData(post),
                        HtmlContent(post.content),
                      ],
                    ),
                  )
                : Row(
                    children: <Widget>[
                      SingleChildScrollView(
                        controller: controller1,
                        physics: const BouncingScrollPhysics(),
                        child: SizedBox(
                          width: size.width / 3,
                          child: Column(
                            children: <Widget>[
                              Hero(
                                tag: post.image,
                                child: CachedImage(
                                  post.image,
                                  width: size.width,
                                ),
                              ),
                              PostDetailData(post),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: controller2,
                          physics: const BouncingScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minWidth: MediaQuery.of(context).size.width,
                                minHeight: MediaQuery.of(context).size.height),
                            child: IntrinsicHeight(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  HtmlContent(post.content),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
