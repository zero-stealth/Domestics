import 'package:domestics/Functions/http_service.dart';
import 'package:domestics/data/colors.dart';
import 'package:domestics/screens/Selections.dart';
import 'package:domestics/widgets/Dialog.dart';
import 'package:domestics/widgets/Forms/AuthBtn.dart';
import 'package:domestics/widgets/Forms/ErrorAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../widgets/Forms/InputWidget.dart';
import 'Login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  bool errorStatus = false;
  String errorMessage = "";
  String buttonState = 'notloading';

  void _popup() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return MyDialog(
            title: 'Working on it',
            content: 'This feature will be available soon.',
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

  buttonStatus(buttonState) {
    switch (buttonState) {
      case "loading":
        return LoadingAnimationWidget.inkDrop(
          color: dWhitePure,
          size: 20.0,
        );

      default:
        return Text(
          'Register',
          style: TextStyle(
              color: dWhitePure, fontSize: 16.0, fontFamily: 'SFD-Bold'),
        );
    }
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
                  'Welcome',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 26.0,
                    fontFamily: 'SFD-Bold',
                    color: dBlack,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Lets get you signed up.',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'SFT-Regular',
                    color: dBlack,
                  ),
                ),
                const SizedBox(height: 30.0),
                InputWidget(
                  label: "First Name",
                  placeholder: "john",
                  mycontroller: fnameController,
                  obscure: false,
                ),
                const SizedBox(height: 15.0),
                InputWidget(
                  label: "Last Name",
                  placeholder: "cena",
                  mycontroller: lnameController,
                  obscure: false,
                ),
                const SizedBox(height: 15.0),
                InputWidget(
                  label: "Password",
                  placeholder: "***********",
                  mycontroller: passwordController,
                  obscure: true,
                ),
                const SizedBox(height: 15.0),
                InputWidget(
                  label: "Confirm Password",
                  placeholder: "***********",
                  mycontroller: confirmController,
                  obscure: true,
                ),
                const SizedBox(height: 10.0),
                ErrorAlert(
                  errorMessage: errorMessage,
                  status: errorStatus,
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
                    child: buttonStatus(buttonState),
                    onPressed: () async {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Selections()),
                      // );
                      setState(() {
                        errorStatus = false;
                        buttonState = 'loading';
                      });

                      if (fnameController.text.length <= 0 ||
                          lnameController.text.length <= 0) {
                        return setState(() {
                          errorMessage = "Fill all fields.";
                          errorStatus = true;
                          buttonState = 'notloading';
                        });
                      } else {
                        print("[+] All fields filled.");
                      }

                      if (passwordController.text != confirmController.text) {
                        print('[----] Passwords dont match');
                        return setState(() {
                          errorMessage = "Password don\'t match!";
                          errorStatus = true;
                          buttonState = 'notloading';
                        });
                      } else {
                        print('[+] Passwords match!!!');

                        try {
                          bool createStatus = await createAccount(
                            fnameController.text,
                            lnameController.text,
                            "Hello, i love domestics",
                            "0000000000",
                            passwordController.text,
                            emailController.text,
                          );

                          switch (createStatus) {
                            case true:
                              print('[+] Created successfully.');
                              break;
                            default:
                              print('[--] Failed to create account');
                              break;
                          }

                          setState(() {
                            buttonState = 'notloading';
                          });
                        } catch (e) {
                          setState(() {
                            buttonState = 'notloading';
                          });
                          print(e);
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(height: 5.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Center(
                    child: Text(
                      'Already have an account? Log in',
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
