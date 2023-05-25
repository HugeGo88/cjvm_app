import 'package:cjvm_app/model/navigation_item_entitiy.dart';
import 'package:cjvm_app/widgets/group_list_item.dart';
import 'package:cjvm_app/widgets/loading_fullscreen.dart';
import 'package:flutter/widgets.dart';
import '../utils/color_utils.dart' as color_utils;

class GroupList extends StatelessWidget {
  final List<NavigationItemEntitiy> allNavigationItems;
  GroupList(this.allNavigationItems, {super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return allNavigationItems.isEmpty
        ? const LoadingFullscreen()
        : ListView.separated(
            itemBuilder: groupTile,
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: color_utils.commonThemeData.primaryColor,
            ),
            itemCount: allNavigationItems.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
          );
  }

  Widget groupTile(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: GroupListItem(allNavigationItems[index]),
    );
  }
}
