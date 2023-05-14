import 'package:cjvm_app/model/navigation_item_entitiy.dart';
import 'package:cjvm_app/network/wp_api.dart';
import 'package:cjvm_app/pages/detail_elementes/html_content.dart';
import 'package:cjvm_app/widgets/loading_fullscreen.dart';
import 'package:flutter/widgets.dart';
import '../utils/constants.dart';
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
    String requestUrl = "${baseUrl}pages?slug=${widget.navigationItem.slug}";
    WpApi.getPageList(requestUrl: requestUrl).then(
      (pages) {
        setState(
          () {
            htmlContent = pages[0].content;
          },
        );
      },
    );
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
      body: htmlContent == ""
          ? const LoadingFullscreen()
          : HtmlContent(htmlContent),
    );
  }
}
