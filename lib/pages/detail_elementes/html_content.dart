import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlContent extends StatelessWidget {
  final String data;
  const HtmlContent(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      style: {
        "a": Style(textDecoration: TextDecoration.none),
        "ul": Style(textDecoration: TextDecoration.none),
        "li": Style(textDecoration: TextDecoration.none),
        "p": Style(textDecoration: TextDecoration.none),
      },
    );
  }
}
