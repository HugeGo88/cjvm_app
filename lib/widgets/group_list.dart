import 'package:cjvm_app/widgets/group_list_item.dart';
import 'package:cjvm_app/widgets/post_list_item.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../utils/color_utils.dart' as color_utils;

class GroupList extends StatefulWidget {
  const GroupList({super.key});

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  List<String> allGroups = [
    "Offener Abend",
    "Sport",
    "Gangnai",
    "Jungschar",
    "Jungschar",
    "Jungschar",
    "Jungschar"
  ];
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: groupTile,
      separatorBuilder: (context, index) => Container(
        height: 1,
        color: color_utils.commonThemeData.primaryColor,
      ),
      itemCount: allGroups.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
    );
  }

  Widget groupTile(BuildContext context, int index) {
    if (index == allGroups.length) {
      return _buildProgressIndicator();
    } else {
      return GroupListItem(allGroups[index]);
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
