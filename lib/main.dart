import 'package:cjvm_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'utils/color_utils.dart' as color_utils;
import 'widgets/home_widget.dart';

void main() {
  runApp(const CvjmApp());
}

class CvjmApp extends StatelessWidget {
  const CvjmApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: color_utils.commonThemeData.primaryColor,
        brightness: Brightness.light,
        cupertinoOverrideTheme: CupertinoThemeData(
            primaryColor: color_utils.commonThemeData.primaryColor),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: color_utils.commonThemeData.primaryColor,
        colorScheme: const ColorScheme.dark(background: Colors.black),
        scaffoldBackgroundColor: Colors.black,
        bottomAppBarTheme: const BottomAppBarTheme(color: Colors.black),
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: color_utils.commonThemeData.primaryColor,
          barBackgroundColor: Colors.black,
          primaryContrastingColor: color_utils.commonThemeData.primaryColor,
          scaffoldBackgroundColor: Colors.black,
          brightness: Brightness.dark,
          textTheme: const CupertinoTextThemeData(
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeWidget(),
    );
  }
}
