import 'package:cjvm_app/pages/events_tab.dart';
import 'package:cjvm_app/pages/start_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../pages/posts_tab.dart';

final titles = ['Aktuelles', 'Termine', 'Berichte', 'Gruppen'];

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
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
  Widget build(BuildContext context) {
    return Material(
      child: PlatformTabScaffold(
        materialTabs: (_, __) =>
            MaterialNavBarData(type: BottomNavigationBarType.fixed),
        appBarBuilder: (_, index) => PlatformAppBar(
          title: Text(
            titles[index],
          ),
          trailingActions: [
            PlatformIconButton(
              icon: Icon(PlatformIcons(context).info),
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
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                            'Alle wichtigen Informationen können auf der Homepage eingesehen werden.'))
                  ],
                );
              },
            ),
          ],
        ),
        tabController: tabController,
        items: items(context),
        bodyBuilder: (BuildContext context, int index) => ParentView(
          title: titles[index],
          child: ContentView(index: index),
        ),
      ),
    );
  }

  items(BuildContext context) => [
        BottomNavigationBarItem(
          label: titles[0],
          icon: Icon(PlatformIcons(context).home),
        ),
        BottomNavigationBarItem(
          label: titles[1],
          icon: const Icon(
            CupertinoIcons.calendar,
          ),
        ),
        BottomNavigationBarItem(
          label: titles[2],
          icon: Icon(PlatformIcons(context).collections),
        ),
/*         BottomNavigationBarItem(
          label: titles[3],
          icon: Icon(PlatformIcons(context).group),
        ), */
      ];

  // This needs to be captured here in a stateful widget
  PlatformTabController tabController = PlatformTabController();
  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }
}

@immutable
class ParentView extends StatelessWidget {
  final String title;
  final Widget child;

  const ParentView({super.key, required this.title, required this.child});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: child,
    );
  }
}

@immutable
class ContentView extends StatelessWidget {
  final int index;

  const ContentView({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const StartTab();
      case 1:
        return const EventsTab();
      case 2:
        return const PostsTab();
      //case 3:
      //  return const Placeholder();
      default:
        return Container();
    }
  }
}
