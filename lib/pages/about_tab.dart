import 'package:cjvm_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';

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

  void getData() {
    //TODO create function to handle all the calls
    //TODO needs to be fixed
    String requestUrl =
        "https://cvjm-walheim.de/wp-json/wp/v2/pages?slug=vereinsleitung/";
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
    _initPackageInfo();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return htmlContent == ""
        ? const LoadingFullscreen()
        : Column(
            children: [
              Flexible(child: HtmlContent(htmlContent)),
              PlatformTextButton(
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
                    applicationLegalese: '©2024 cvjm-walheim.de',
                    children: <Widget>[
                      const Padding(
                          padding: EdgeInsets.only(top: edgePadding * 2),
                          child: Text(
                              'Alle wichtigen Informationen können auf der Homepage eingesehen werden.'))
                    ],
                  );
                },
              ),
            ],
          );
  }
}
