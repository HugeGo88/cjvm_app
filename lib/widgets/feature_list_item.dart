import 'package:cjvm_app/model/cached_image.dart';
import 'package:cjvm_app/model/post_entitiy.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../pages/post_detail.dart';
import '../utils/color_utils.dart' as color_utils;
import 'package:flutter/material.dart';

class FeatureListItem extends StatelessWidget {
  final PostEntity post;
  const FeatureListItem(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width * 0.8;

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
          height: 200,
          width: width,
          child: Stack(
            children: <Widget>[
              Hero(
                  tag: post.image,
                  child: CachedImage(
                    post.image,
                    height: size.height,
                    width: width,
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
                      width: width,
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
                      width: width,
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
