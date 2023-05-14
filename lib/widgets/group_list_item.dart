import 'package:cjvm_app/model/navigation_item_entitiy.dart';
import 'package:cjvm_app/pages/group_detail.dart';
import 'package:cjvm_app/widgets/group_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../utils/color_utils.dart' as color_utils;

import '../utils/constants.dart';

class GroupListItem extends StatelessWidget {
  final NavigationItemEntitiy groupName;

  const GroupListItem(this.groupName, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
            context,
            platformPageRoute(
                builder: (context) => groupName.childItems.isNotEmpty
                    ? Placeholder()
                    : GroupDetail(groupName),
                context: context));
      },
      child: SizedBox(
        height: listHeight,
        child: Row(
          children: [
            Expanded(
              child: Text(
                groupName.title,
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
      ),
    );
  }
}
