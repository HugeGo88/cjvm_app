import 'package:cjvm_app/model/navigation_item_entitiy.dart';
import 'package:cjvm_app/network/wp_api.dart';
import 'package:cjvm_app/pages/detail_elementes/html_content.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class GroupDetail extends StatefulWidget {
  final NavigationItemEntitiy navigationItem;

  const GroupDetail(this.navigationItem, {super.key});

  @override
  State<GroupDetail> createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  String htmlContent = "";

  void getData() {
    //TODO needs to be fixed
    /*
    WpApi.getHtml(requestUrl: widget.navigationItem.url).then(
      (item) {
        setState(
          () {
            htmlContent = item;
          },
        );
      },
    );
    */
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      iosContentPadding: true,
      appBar: PlatformAppBar(title: Text(widget.navigationItem.title)),
      //TODO Display page content
      //body: HtmlContent(htmlContent),
      body: Placeholder(),
    );
  }
}
