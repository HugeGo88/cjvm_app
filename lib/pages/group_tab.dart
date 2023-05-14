import 'package:cjvm_app/model/navigation_item_entitiy.dart';
import 'package:cjvm_app/network/wp_api.dart';
import 'package:cjvm_app/utils/constants.dart';
import 'package:cjvm_app/widgets/group_list.dart';
import 'package:flutter/src/widgets/framework.dart';

class GroupTab extends StatefulWidget {
  const GroupTab({super.key});

  @override
  State<GroupTab> createState() => _GroupTabState();
}

class _GroupTabState extends State<GroupTab> {
  List<NavigationItemEntitiy> allNavigationItems = [];

  void getData() {
    WpApi.getNavigationItemList(id: groupMenuId).then(
      (navigationItems) {
        setState(
          () {
            allNavigationItems.addAll(navigationItems);
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return GroupList(allNavigationItems);
  }
}
