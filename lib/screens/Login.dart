import 'package:domestics/data/colors.dart';
import 'package:domestics/screens/Register.dart';
import 'package:domestics/screens/Selections.dart';
import 'package:domestics/screens/Who.dart';
import 'package:domestics/widgets/Dialog.dart';
import 'package:domestics/widgets/Forms/InputWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/Forms/AuthBtn.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();

  void _popup() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return MyDialog(
            title: 'Working on it',
            content: 'This feature will be available soon.',
            backgroundColor: Colors.redAccent,
            textColor: dBlack,
            continueWidget: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 80,
                  child: CupertinoButton(
                    padding: const EdgeInsets.all(10.0),
                    color: dGreyFaded,
                    child: Text(
                      'If you say so',
                      style: TextStyle(
                        color: dBlack,
                        fontSize: 16.0,
                        fontFamily: 'SFT-Regular',
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dBackgroundWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40.0),
                Text(
                  'Welcome back',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 26.0,
                    fontFamily: 'SFD-Bold',
                    color: dBlack,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Lets go!',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'SFT-Regular',
                    color: dBlack,
                  ),
                ),
                const SizedBox(height: 30.0),
                InputWidget(
                  label: "Email",
                  placeholder: "someone@gmail.com",
                  mycontroller: emailController,
                  obscure: false,
                ),
                const SizedBox(height: 15.0),
                InputWidget(
                  label: "Password",
                  placeholder: "***********",
                  mycontroller: emailController,
                  obscure: true,
                ),
                const SizedBox(height: 15.0),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    bottom: 20.0,
                    left: 0.0,
                    right: 0.0,
                  ),
                  child: CupertinoButton(
                    color: dBlueBackground,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: dWhitePure,
                        fontSize: 16.0,
                        fontFamily: 'SFD-Bold',
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Selections()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Register()),
                    );
                  },
                  child: Center(
                    child: Text(
                      'Don\'t have an account? Register',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
