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
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            platformPageRoute(
                builder: (context) => PostDetail(post), context: context));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: featureHeigt,
          width: featureWidth,
          child: Stack(
            children: <Widget>[
              Hero(
                  tag: post.image,
                  child: CachedImage(
                    post.image,
                    height: featureHeigt,
                    width: featureWidth,
                    fit: BoxFit.cover,
                  )),
              Positioned(
                bottom: 0,
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xff292929),
                      ),
                      width: featureWidth,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          post.title.toUpperCase(),
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
                      width: featureWidth,
                      color: color_utils.commonThemeData.primaryColor,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
