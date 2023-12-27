import 'dart:async';
import 'package:flutter_html/flutter_html.dart';

import 'package:cjvm_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/color_utils.dart' as color_utils;

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
      child: Padding(
        padding: const EdgeInsets.all(edgePadding),
        child: Material(
          child: Html(
            data: data,
            onLinkTap: (url, attributes, element) {
              var attributes = element?.attributes;
              if (attributes != null) {
                for (var entry in attributes.entries) {
                  var url = entry.value;
                  _launchInBrowser(Uri.parse(url));
                }
              }
            },
            style: {
              "blockquote": Style(
                margin: Margins(left: Margin(0)),
                padding: HtmlPaddings(left: HtmlPadding(edgePadding * 2)),
                fontStyle: FontStyle.italic,
                border: Border(
                  left: BorderSide(
                      color: color_utils.commonThemeData.primaryColor,
                      style: BorderStyle.solid,
                      width: 5.0),
                ),
              ),
              "a": Style(
                  textDecoration: TextDecoration.none,
                  color: color_utils.commonThemeData.primaryColor),
              "p": Style(textDecoration: TextDecoration.none),
              "li": Style(listStyleType: ListStyleType.square),
            },
          ),
        ),
      ),
    );
  }
}
