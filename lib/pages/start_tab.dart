import 'package:cjvm_app/utils/constants.dart';
import 'package:cjvm_app/widgets/event_list.dart';
import 'package:cjvm_app/widgets/feature_list.dart';
import 'package:cjvm_app/widgets/list_heading.dart';
import 'package:cjvm_app/widgets/post_list.dart';
import 'package:flutter/cupertino.dart';

class StartTab extends StatelessWidget {
  const StartTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListHeading(important),
          const SizedBox(
            height: 250,
            child: FeatureList(),
          ),
          const ListHeading(posts),
          const PostList(
            category: 0,
            maxPosts: 3,
            showFeatureCategory: false,
          ),
          Container(
            height: 8,
          ),
          const ListHeading(events),
          const EventList(
            maxEvents: 3,
          )
        ],
      ),
    );
  }
}