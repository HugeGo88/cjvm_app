import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../utils/color_utils.dart' as color_utils;
import 'package:intl/intl.dart';

import '../model/cached_image.dart';
import '../model/post_entitiy.dart';

class PostDetail extends StatelessWidget {
  final PostEntity post;

  const PostDetail(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    initializeDateFormatting();
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait
            ? PlatformScaffold(
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
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Erstellt: ",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    DateFormat.yMMMd('de').format(
                                        DateTime.parse(post.modifiedGmt)),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  height: 3.0,
                                  width: MediaQuery.of(context).size.width,
                                  color:
                                      color_utils.commonThemeData.primaryColor,
                                ),
                              ),
                              Html(
                                data: post.content,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : PlatformScaffold(
                iosContentPadding: true,
                appBar: PlatformAppBar(
                  title: Text(
                    post.title,
                  ),
                ),
                body: SafeArea(
                  top: false,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    PlatformIcons(context).time,
                                    size: 35,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Aktualisiert: ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            Text(
                                              DateFormat.yMMMd('de').format(
                                                  DateTime.parse(
                                                      post.modifiedGmt)),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
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
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Container(
                                height: 3.0,
                                width: MediaQuery.of(context).size.width,
                                color: color_utils.commonThemeData.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minWidth: MediaQuery.of(context).size.width,
                                minHeight: MediaQuery.of(context).size.height),
                            child: IntrinsicHeight(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Html(
                                    data: post.content,
                                    style: {
                                      "a": Style(
                                          textDecoration: TextDecoration.none),
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
