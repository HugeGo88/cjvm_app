import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LoadingFullscreen extends StatelessWidget {
  const LoadingFullscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PlatformCircularProgressIndicator(),
    );
  }
}
