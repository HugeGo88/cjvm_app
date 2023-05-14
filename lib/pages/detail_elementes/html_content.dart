import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../utils/color_utils.dart' as color_utils;

class HtmlContent extends StatelessWidget {
  final String data;
  const HtmlContent(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Html(
        data: data,
        style: {
          "a": Style(textDecoration: TextDecoration.none),
          "p": Style(textDecoration: TextDecoration.none),
          "li": Style(
            listStyleType: ListStyleType.fromWidget(
              const Icon(
                Icons.square,
                size: 10,
              ),
            ),
          )
        },
      ),
    );
  }
}
