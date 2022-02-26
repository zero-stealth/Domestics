// ignore: file_names
import 'package:domestics/screens/Selections.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loading = false;
  Widget loadingStuff = Container();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        loadingStuff = Container(
          margin: const EdgeInsets.only(bottom: 100.0),
          child: const CupertinoActivityIndicator(
            animating: true,
            radius: 20.0,
          ),
        );
      });

      Future.delayed(const Duration(seconds: 2), (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Selections()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffda4b2e),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Hero(
                  tag: 'logo',
                  child: Image(
                    image: AssetImage("assets/paw.png"),
                    height: 150.0,
                  ),
                ),
                SizedBox(height: 25.0),
                Text(
                  "Domestics",
                  style: TextStyle(
                      fontFamily: 'SFD-Bold',
                      fontSize: 20.0,
                      color: Color(0xfffdfbfa)),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: loadingStuff,
          ),
        ],
      ),
    );
  }
}
