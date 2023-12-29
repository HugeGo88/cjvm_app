import 'package:cjvm_app/pages/about_tab.dart';
import 'package:cjvm_app/pages/events_tab.dart';
import 'package:cjvm_app/pages/group_tab.dart';
import 'package:cjvm_app/pages/start_tab.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../pages/posts_tab.dart';

final titles = ['Aktuelles', 'Termine', 'Berichte', 'Gruppen', 'Über'];

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
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
        BottomNavigationBarItem(
          label: titles[3],
          icon: Icon(PlatformIcons(context).person),
        ),
        BottomNavigationBarItem(
          label: titles[4],
          icon: Icon(PlatformIcons(context).info),
        ),
      ];

  // This needs to be captured here in a stateful widget
  PlatformTabController tabController = PlatformTabController();
  @override
  void initState() {
    analytics.setAnalyticsCollectionEnabled(true);
    super.initState();
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
class ContentView extends StatefulWidget {
  final int index;

  const ContentView({super.key, required this.index});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: analytics.logEvent(
        name: "pages_tracked",
        parameters: {
          "page_name": titles[widget.index],
          "page_index": widget.index
        },
      ),
      builder: (context, snapshot) {
        switch (widget.index) {
          case 0:
            return const StartTab();
          case 1:
            return const EventsTab();
          case 2:
            return const PostsTab();
          case 3:
            return const GroupTab();
          case 4:
            return const AboutTab();
          default:
            return const Placeholder();
        }
      },
    );
  }
}
