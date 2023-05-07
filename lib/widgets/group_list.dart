import 'package:cjvm_app/model/navigation_item_entitiy.dart';
import 'package:cjvm_app/network/wp_api.dart';
import 'package:cjvm_app/widgets/group_list_item.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../utils/color_utils.dart' as color_utils;

class GroupList extends StatefulWidget {
  const GroupList({super.key});

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  List<NavigationItemEntitiy> allNavigationItems = [];
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  void getData() {
    if (!isLoading) {
      setState(
        () {
          isLoading = true;
        },
      );

      WpApi.getNavigationItemList(id: 121).then(
        (navigationItems) {
          setState(
            () {
              isLoading = false;
              allNavigationItems.addAll(navigationItems);
            },
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: groupTile,
      separatorBuilder: (context, index) => Container(
        height: 1,
        color: color_utils.commonThemeData.primaryColor,
      ),
      itemCount: allNavigationItems.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
    );
  }

  Widget groupTile(BuildContext context, int index) {
    if (index == allNavigationItems.length) {
      return _buildProgressIndicator();
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: GroupListItem(allNavigationItems[index]),
      );
    }
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Visibility(
          visible: isLoading,
          child: PlatformCircularProgressIndicator(),
        ),
      ),
    );
  }
}
