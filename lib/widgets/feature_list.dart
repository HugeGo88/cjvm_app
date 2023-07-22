import 'package:cjvm_app/model/post_entitiy.dart';
import 'package:cjvm_app/widgets/loading_fullscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(
      () {
        _packageInfo = info;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();

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
        ? const LoadingFullscreen()
        : ListView.builder(
            itemCount: allPosts.length + 1,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => (index != allPosts.length)
                ? FeatureListItem(allPosts[index])
                : PlatformTextButton(
                    child: const Text("Über diese App"),
                    onPressed: () {
                      showAboutDialog(
                        context: context,
                        applicationIcon: Image.asset(
                          'images/logo.png',
                          width: 50,
                          fit: BoxFit.fitWidth,
                        ),
                        applicationName: 'CVJM Walheim',
                        applicationVersion:
                            '${_packageInfo.version}.(${_packageInfo.buildNumber})',
                        applicationLegalese: '©2023 cvjm-walheim.de',
                        children: <Widget>[
                          const Padding(
                              padding: EdgeInsets.only(top: edgePadding * 2),
                              child: Text(
                                  'Alle wichtigen Informationen können auf der Homepage eingesehen werden.'))
                        ],
                      );
                    },
                  ),
          );
  }
}
