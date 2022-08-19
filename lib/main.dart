import 'package:domestics/data/colors.dart';
import 'package:domestics/screens/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // cupertinoOverrideTheme: const CupertinoThemeData(
        //   brightness: Brightness.light,
        // ),
        // appBarTheme: AppBarTheme(
        //   systemOverlayStyle: SystemUiOverlayStyle.dark,
        //   // systemOverlayStyle: SystemUiOverlayStyle(
        //   //   statusBarBrightness: Brightness.light,
        //   //   systemNavigationBarColor: dBackgroundWhite,
        //   //   statusBarColor: dBackgroundWhite,
        //   //   systemNavigationBarDividerColor: dBackgroundWhite,
        //   // ),
        //),
      ),
      home: const SplashScreen(),
    );
  }
}
