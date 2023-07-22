import 'package:cjvm_app/utils/constants.dart';
import 'package:cjvm_app/widgets/event_list.dart';
import 'package:cjvm_app/widgets/feature_list.dart';
import 'package:cjvm_app/widgets/list_heading.dart';
import 'package:cjvm_app/widgets/post_list.dart';
import 'package:flutter/cupertino.dart';

class StartTab extends StatelessWidget {
  const StartTab({super.key});
//TODO: Check why feature list doesnt reload during reload, but the other lists
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait
            ? const FeatureList()
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const ListHeading(important),
                    const SizedBox(
                      height: featureHeigt + 50,
                      child: FeatureList(),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: const <Widget>[
                              ListHeading(events),
                              EventList(
                                maxEvents: 5,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: const <Widget>[
                              ListHeading(posts),
                              PostList(
                                category: 0,
                                maxPosts: 5,
                                showFeatureCategory: false,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
      },
    );
  }
}
