import 'package:cjvm_app/model/post_embedded.dart';
import 'package:cjvm_app/model/post_entitiy.dart';
import 'package:flutter/cupertino.dart';

import 'feature_list_item.dart';

class FeatureList extends StatefulWidget {
  const FeatureList({super.key});

  @override
  State<FeatureList> createState() => _FeatureListState();
}

class _FeatureListState extends State<FeatureList> {
  List<PostEntity> posts = <PostEntity>[
    PostEntity(
        extra: PostEmbedded(),
        modifiedGmt: "",
        link: "",
        id: 1,
        title: "Test1",
        content: "content1"),
    PostEntity(
        extra: PostEmbedded(),
        modifiedGmt: "",
        link: "",
        id: 1,
        title: "Test2",
        content: "content2"),
    PostEntity(
        extra: PostEmbedded(),
        modifiedGmt: "",
        link: "",
        id: 1,
        title: "Test3",
        content: "content3"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return FeatureListItem(posts[index]);
      },
    );
  }
}
