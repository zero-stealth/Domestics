// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffda4b2e),
      body: Align(
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("assets/paw.png"),
                height: 150.0,
              ),
              const SizedBox(height: 25.0),
              const Text(
                "Domestics",
                style: TextStyle(
                  fontFamily: 'SFD-Bold',
                  fontSize: 20.0,
                  color: Color(0xfffdfbfa)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
