import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

final titles = ['Aktuelles', 'Berichte', 'Termine', 'Mitteilungen'];

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
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
        bodyBuilder: contentBuilder,
      ),
    );
  }

  final items = (BuildContext context) => [
        BottomNavigationBarItem(
          label: titles[0],
          icon: Icon(PlatformIcons(context).home),
        ),
        BottomNavigationBarItem(
          label: titles[1],
          icon: Icon(PlatformIcons(context).collections),
        ),
        BottomNavigationBarItem(
          label: titles[2],
          icon: const Icon(
            CupertinoIcons.calendar,
          ),
        ),
      ];

  final contentBuilder = (BuildContext context, int index) => ParentView(
        title: titles[index],
        child: Text(index.toString()),
      );

  // This needs to be captured here in a stateful widget
  PlatformTabController tabController = PlatformTabController();
  @override
  void initState() {
    super.initState();
  }
}

class ParentView extends StatelessWidget {
  ParentView({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: child,
    );
  }
}
