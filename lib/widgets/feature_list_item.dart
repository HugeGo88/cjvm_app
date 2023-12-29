import 'package:cjvm_app/model/cached_image.dart';
import 'package:cjvm_app/model/post_entitiy.dart';
import 'package:cjvm_app/utils/constants.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../pages/post_detail.dart';
import '../utils/color_utils.dart' as color_utils;
import 'package:flutter/material.dart';

class FeatureListItem extends StatelessWidget {
  final PostEntity post;
  const FeatureListItem(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    double? imageHeight = post.extra.image?.first.height?.toDouble();
    double? imageWidth = post.extra.image?.first.width?.toDouble();
    double? actualHeight;
    if (imageHeight != null && imageWidth != null) {
      actualHeight =
          imageHeight * (MediaQuery.of(context).size.width / imageWidth);
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            platformPageRoute(
                builder: (context) => PostDetail(post), context: context));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: edgePadding * 2),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Hero(
                tag: post.image,
                child: CachedImage(
                  post.image,
                  width: MediaQuery.of(context).size.width,
                  // TODO make sure there will be no null
                  height: actualHeight,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xff292929),
                ),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: edgePadding, vertical: contentPadding),
                  child: Text(
                    post.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                height: 3,
                width: MediaQuery.of(context).size.width,
                color: color_utils.commonThemeData.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
