import 'package:cjvm_app/model/post_entitiy.dart';
import 'package:cjvm_app/widgets/post_list_item.dart';
import 'package:flutter/cupertino.dart';
import '../utils/color_utils.dart' as color_utils;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
  List<PostEntity> posts = <PostEntity>[
    PostEntity(
        modifiedGmt: "", link: "", id: 1, title: "Test1", content: "content1"),
    PostEntity(
        modifiedGmt: "", link: "", id: 1, title: "Test2", content: "content2"),
    PostEntity(
        modifiedGmt: "", link: "", id: 1, title: "Test3", content: "content3"),
  ];

  int page = 0;
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: postTile,
      separatorBuilder: (context, index) => Container(
        height: 1,
        color: color_utils.commonThemeData.primaryColor,
      ),
      itemCount:
          posts.length + 1 < widget.maxPosts ? posts.length : widget.maxPosts,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
    );
  }

  Widget postTile(BuildContext context, int index) {
    if (index == posts.length) {
      return _buildProgressIndicator();
    } else {
      return PostListItem(posts[index]);
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
