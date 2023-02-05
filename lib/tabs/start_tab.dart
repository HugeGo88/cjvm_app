import 'package:cjvm_app/utils/constants.dart';
import 'package:cjvm_app/widgets/list_heading.dart';
import 'package:flutter/cupertino.dart';

class StartTab extends StatelessWidget {
  const StartTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListHeading(important),
          Container(
            height: 250,
          ),
          const ListHeading(posts),
          Container(
            height: 8,
          ),
          const ListHeading(events),
        ],
      ),
    );
  }
}
