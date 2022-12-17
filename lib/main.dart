import 'package:domestics/data/colors.dart';
import 'package:domestics/screens/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
      title: 'Domestics',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: dWhitePure,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: dWhitePure,
            statusBarColor: dWhitePure,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
