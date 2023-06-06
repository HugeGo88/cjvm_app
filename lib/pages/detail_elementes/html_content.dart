import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

class HtmlContent extends StatelessWidget {
  final String data;
  const HtmlContent(this.data, {super.key});

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: HtmlWidget(
        data.replaceAll("src=\" ", "src=\""),
        textStyle: Theme.of(context).textTheme.bodyMedium,
        onTapUrl: (url) {
          _launchInBrowser(Uri.parse(url));
          return true;
        },
        /*
        onLinkTap: (url, attributes, element) {
          var attributes = element?.attributes;
          if (attributes != null) {
            for (var attribute in attributes.entries) {
              if (attribute.key == "href") {
                var url = attribute.value;
                _launchInBrowser(Uri.parse(url));
              }
            }
          }
        },*/
      ),
    );
  }
}
