import 'package:cjvm_app/model/post_entitiy.dart';
import 'package:cjvm_app/widgets/post_list_item.dart';
import 'package:flutter/cupertino.dart';
import '../network/wp_api.dart';
import '../utils/color_utils.dart' as color_utils;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../utils/constants.dart';

class PostList extends StatefulWidget {
  final int category;
  final int maxPosts;
  final bool showFeatureCategory;
  const PostList(
      {required this.category,
      this.maxPosts = 100,
      this.showFeatureCategory = true,
      super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List<PostEntity> allPosts = <PostEntity>[];

  int page = 0;
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  void getData() {
    if (!isLoading) {
      setState(
        () {
          page++;
          isLoading = true;
        },
      );

      WpApi.getPostsList(category: widget.category, page: page).then(
        (posts) {
          setState(
            () {
              isLoading = false;
              if (widget.showFeatureCategory) {
                allPosts.addAll(posts);
              } else {
                for (var post in posts) {
                  if (post.category != featuredCategoryName) {
                    allPosts.add(post);
                  }
                }
              }
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
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          getData();
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: postTile,
      separatorBuilder: (context, index) => Container(
        height: 1,
        color: color_utils.commonThemeData.primaryColor,
      ),
      itemCount: allPosts.length + 1 < widget.maxPosts
          ? allPosts.length + 1
          : widget.maxPosts,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
    );
  }

  Widget postTile(BuildContext context, int index) {
    if (index == allPosts.length) {
      return _buildProgressIndicator();
    } else {
      return PostListItem(allPosts[index]);
    }
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(edgePadding),
      child: Center(
        child: Visibility(
          visible: isLoading,
          child: PlatformCircularProgressIndicator(),
        ),
      ),
    );
  }
}
