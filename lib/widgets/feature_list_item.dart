import 'package:cjvm_app/model/post_entitiy.dart';
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
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 200,
          width: width,
          child: Stack(
            children: <Widget>[
              Hero(
                tag: post.image,
                child: SizedBox(
                  width: width,
                  height: size.height,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(color: Colors.black),
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          post.title.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
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
