import 'package:cjvm_app/model/post_entitiy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../network/wp_api.dart';
import '../utils/constants.dart';
import 'feature_list_item.dart';

class FeatureList extends StatefulWidget {
  const FeatureList({super.key});

  @override
  State<FeatureList> createState() => _FeatureListState();
}

class _FeatureListState extends State<FeatureList> {
  List<PostEntity> allPosts = <PostEntity>[];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    WpApi.getPostsList(category: featuredCategoryId).then(
      (posts) {
        setState(
          () {
            isLoading = false;
            allPosts.addAll(posts);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: PlatformCircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: allPosts.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return FeatureListItem(allPosts[index]);
            },
          );
  }
}
