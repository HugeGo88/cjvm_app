import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../network/wp_api.dart';
import '../widgets/loading_fullscreen.dart';
import 'detail_elementes/html_content.dart';

class AboutTab extends StatefulWidget {
  const AboutTab({super.key});

  @override
  State<AboutTab> createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> {
  String htmlContent = "";

  void getData() {
    //TODO create function to handle all the calls
    //TODO needs to be fixed
    String requestUrl =
        "https://cvjm-walheim.de/wp-json/wp/v2/pages?slug=ueber-uns";
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
      appBar: PlatformAppBar(title: Text("Über uns")),
      body: htmlContent == ""
          ? const LoadingFullscreen()
          : HtmlContent(htmlContent),
    );
  }
}
