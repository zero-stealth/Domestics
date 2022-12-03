// ignore: file_names
import 'package:domestics/Functions/http_service.dart';
import 'package:domestics/Functions/requests.dart';
import 'package:domestics/data/colors.dart';
import 'package:domestics/database/database_helper.dart';
import 'package:domestics/screens/Dashboard.dart';
import 'package:domestics/screens/Selections.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../controllers/workers_controller.dart';
import 'Login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _dbHelper = DatabaseHelper.instance;
  bool loading = false;
  Widget loadingStuff = Container();

  checkToken() async {
    var count = await _dbHelper.queryRowCount("userInfo");

    if (count! <= 0) {
      return Future.delayed(const Duration(seconds: 4), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      });
    }

    var info = await _dbHelper.queryAllRows("userInfo");
    var response = await getRequest(info[0]['token'], "/users/me");

    if (response.statusCode == 200) {
      await populateData(info[0]['token']);
      await getWorkers();
      return Future.delayed(const Duration(seconds: 4), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      });
    } else {
      return Future.delayed(const Duration(seconds: 4), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      });
      // throw "Unable to create account";
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      loadingStuff = Container(
        margin: const EdgeInsets.only(bottom: 100.0),
        child: LoadingAnimationWidget.inkDrop(
          color: dWhitePure,
          size: 30.0,
        ),
      );
    });

    checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dBlueBackground,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Hero(
                  tag: 'logo',
                  child: Image(
                    image: AssetImage("assets/paw-white.png"),
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
