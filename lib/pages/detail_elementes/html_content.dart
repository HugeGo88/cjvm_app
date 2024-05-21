import 'dart:async';
import 'package:flutter_html/flutter_html.dart';

import 'package:cjvm_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/color_utils.dart' as color_utils;

class HtmlContent extends StatelessWidget {
  final String data;
  final bool tapLinks;
  final double edge;
  const HtmlContent(this.data,
      {super.key, this.tapLinks = true, this.edge = edgePadding});

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
        padding: EdgeInsets.all(edge),
        child: Material(
          child: Html(
            data: data,
            onLinkTap: (url, attributes, element) {
              var attributes = element?.attributes;
              if (attributes != null && tapLinks) {
                for (var entry in attributes.entries) {
                  var url = entry.value;
                  _launchInBrowser(Uri.parse(url));
                }
              }
            },
            style: {
              "blockquote": Style(
                margin: Margins(left: Margin(-8)),
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
              "p": Style(
                  textDecoration: TextDecoration.none,
                  margin: Margins(left: Margin(-8), top: Margin(0))),
              "h1": Style(
                  textDecoration: TextDecoration.none,
                  margin: Margins(left: Margin(-8), top: Margin(0))),
              "h2": Style(
                  textDecoration: TextDecoration.none,
                  margin: Margins(left: Margin(-8), top: Margin(0))),
              "li": Style(listStyleType: ListStyleType.square),
              "img": Style(
                width: Width(
                  MediaQuery.of(context).size.width - (3 * edgePadding),
                ),
              ),
            },
          ),
        ),
      ),
    );
  }
}
