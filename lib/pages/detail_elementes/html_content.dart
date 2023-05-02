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
        "p": Style(textDecoration: TextDecoration.none),
        "li": Style(
          listStyleType: ListStyleType.fromWidget(
            const Icon(
              Icons.square,
              color: Colors.black,
              size: 10,
            ),
          ),
        )
      },
    );
  }
}
