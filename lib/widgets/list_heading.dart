import 'package:flutter/material.dart';
import 'package:cjvm_app/utils/color_utils.dart' as color_utils;

class ListHeading extends StatelessWidget {
  final String title;
  const ListHeading(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text(
              title.toUpperCase(),
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.apply(fontWeightDelta: 2),
            ),
          ),
          Container(
            height: 3,
            width: MediaQuery.of(context).size.width,
            color: color_utils.commonThemeData.primaryColor,
          )
        ],
      ),
    );
  }
}
