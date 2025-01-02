import 'package:cjvm_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../utils/color_utils.dart' as color_utils;

class HtmlContent extends StatelessWidget {
  final String data;
  final Function(BuildContext)? onTapUrl;
  final double edge;
  const HtmlContent(this.data,
      {super.key, this.onTapUrl, this.edge = edgePadding});

  @override
  Widget build(BuildContext context) {
    final primaryColorHex = color_utils.commonThemeData.primaryColor.value
        .toRadixString(16)
        .substring(2);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(edge),
        child: Material(
          child: HtmlWidget(
            data,
            onTapUrl: (url) {
              if (onTapUrl == null) {
                return false;
              } else {
                onTapUrl!(context);
                return true;
              }
            },
            customStylesBuilder: (element) {
              if (element.localName == 'a') {
                return {
                  'color': '#$primaryColorHex',
                  "text-decoration": "none"
                };
              }
              if (element.localName == 'blockquote') {
                return {
                  'font-style': 'italic',
                  'border-left': '5px solid #$primaryColorHex',
                  'padding-left': '10px',
                  'margin-left': '-20px',
                };
              }
              if (element.localName == 'li') {
                return {
                  'list-style-type': 'square', // Use square for list style
                };
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
