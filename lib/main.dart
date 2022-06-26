import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'color_utils.dart' as color_utils;
import 'home_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CVJM Walheim',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: color_utils.commonThemeData.primaryColor,
        cupertinoOverrideTheme: CupertinoThemeData(
            primaryColor: color_utils.commonThemeData.primaryColor),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: color_utils.commonThemeData.primaryColor,
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        bottomAppBarColor: Colors.black,
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: color_utils.commonThemeData.primaryColor,
          barBackgroundColor: Colors.black,
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
