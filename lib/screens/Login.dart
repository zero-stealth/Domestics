import 'dart:developer';

import 'package:domestics/Functions/Utility.dart';
import 'package:domestics/Functions/http_service.dart';
import 'package:domestics/data/colors.dart';
import 'package:domestics/database/database_helper.dart';
import 'package:domestics/screens/Register.dart';
import 'package:domestics/screens/Selections.dart';
import 'package:domestics/screens/Who.dart';
import 'package:domestics/widgets/Dialog.dart';
import 'package:domestics/widgets/Forms/ErrorAlert.dart';
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
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _errorStatus = false;
  String _errorMessage = "";
  String _buttonState = 'notloading';
  final _dbHelper = DatabaseHelper.instance;

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

  // check() async {
  //   var info = await _dbHelper.queryAllRows("userInfo");
  //   var clientTags = await _dbHelper.queryAllRows("clientTags");
  //   var reviews = await _dbHelper.queryAllRows("reviews");

  //   print(info);
  //   print('----------------');
  //   print(reviews);
  //   print('----------------');
  //   print(clientTags);
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                  mycontroller: _emailController,
                  obscure: false,
                ),
                const SizedBox(height: 15.0),
                InputWidget(
                  label: "Password",
                  placeholder: "***********",
                  mycontroller: _passwordController,
                  obscure: true,
                ),
                const SizedBox(height: 10.0),
                ErrorAlert(
                  errorMessage: _errorMessage,
                  status: _errorStatus,
                ),
                const SizedBox(height: 10.0),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    bottom: 20.0,
                    left: 0.0,
                    right: 0.0,
                  ),
                  child: CupertinoButton(
                    color: dBlueBackground,
                    child: buttonStatus(_buttonState, "Login"),
                    onPressed: () async {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Selections()),
                      // );

                      setState(() {
                        _errorStatus = false;
                        _buttonState = 'loading';
                      });

                      if (_emailController.text.length <= 0 ||
                          _passwordController.text.length <= 0) {
                        return setState(() {
                          _errorMessage = "Fill all fields.";
                          _errorStatus = true;
                          _buttonState = 'notloading';
                        });
                      } else {
                        log("[+] All fields filled.");
                      }

                      try {
                        bool createStatus = await login(
                          _emailController.text,
                          _passwordController.text,
                        );

                        switch (createStatus) {
                          case true:
                            log('[+] Logged in successfully.');
                            break;
                          case false:
                            setState(() {
                              _errorMessage = "Login failed. Confirm your details or register a new account.";
                              _errorStatus = true;
                            });
                        }

                        setState(() {
                          _buttonState = 'notloading';
                        });
                      } catch (e) {
                        setState(() {
                          _buttonState = 'notloading';
                        });
                        print(e);
                      }
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
