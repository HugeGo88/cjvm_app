import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../utils/color_utils.dart' as color_utils;

import '../utils/constants.dart';

class GroupListItem extends StatelessWidget {
  final String groupName;

  const GroupListItem(this.groupName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: listHeight,
      child: Row(
        children: [
          Expanded(
            child: Text(
              groupName,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.apply(fontWeightDelta: 1),
            ),
          ),
          Icon(
            PlatformIcons(context).forward,
            color: color_utils.commonThemeData.primaryColor,
          ),
        ],
      ),
    );
  }
}
