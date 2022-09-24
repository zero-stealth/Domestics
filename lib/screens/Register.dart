import 'package:domestics/Functions/Utility.dart';
import 'package:domestics/Functions/http_service.dart';
import 'package:domestics/data/colors.dart';
import 'package:domestics/screens/Selections.dart';
import 'package:domestics/screens/Setup.dart';
import 'package:domestics/widgets/Dialog.dart';
import 'package:domestics/widgets/Forms/AuthBtn.dart';
import 'package:domestics/widgets/Forms/ErrorAlert.dart';
import 'package:domestics/widgets/popup.dart';
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
  TextEditingController _emailController = TextEditingController();
  TextEditingController _fnameController = TextEditingController();
  TextEditingController _lnameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmController = TextEditingController();

  bool _errorStatus = false;
  String _errorMessage = "";
  String _buttonState = 'notloading';

  void _popup() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return MyDialog(
            title: 'Really!',
            content: 'Your password is too easy.',
            textColor: dWhitePure,
            backgroundColor: Colors.redAccent,
            continueWidget: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 80,
                  child: CupertinoButton(
                    padding: const EdgeInsets.all(10.0),
                    color: Colors.white.withOpacity(0.2),
                    child: Text(
                      'Change it',
                      style: TextStyle(
                        color: dWhitePure,
                        fontSize: 14.0,
                        fontFamily: 'SFT-Regular',
                      ),
                    ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
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
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _fnameController.dispose();
    _lnameController.dispose();
    _phoneController.dispose();
    _confirmController.dispose();
    super.dispose();
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
                  mycontroller: _fnameController,
                  obscure: false,
                  lines: 1,
                ),
                const SizedBox(height: 15.0),
                InputWidget(
                  label: "Last Name",
                  placeholder: "cena",
                  mycontroller: _lnameController,
                  obscure: false,
                  lines: 1,
                ),
                const SizedBox(height: 15.0),
                InputWidget(
                  label: "Email",
                  placeholder: "johncena@gmail.com",
                  mycontroller: _emailController,
                  obscure: false,
                  lines: 1,
                ),
                const SizedBox(height: 15.0),
                InputWidget(
                  label: "Password",
                  placeholder: "***********",
                  mycontroller: _passwordController,
                  obscure: true,
                  lines: 1,
                ),
                const SizedBox(height: 15.0),
                InputWidget(
                  label: "Confirm Password",
                  placeholder: "***********",
                  mycontroller: _confirmController,
                  obscure: true,
                  lines: 1,
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
                    child: buttonStatus(_buttonState, 'Register'),
                    onPressed: () async {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Selections()),
                      // );
                      setState(() {
                        _errorStatus = false;
                        _buttonState = 'loading';
                      });

                      if (_fnameController.text.length <= 0 ||
                          _lnameController.text.length <= 0 ||
                          _emailController.text.length <= 0 ||
                          _passwordController.text.length <= 0 ||
                          _confirmController.text.length <= 0) {
                        return setState(() {
                          _errorMessage = "Fill all fields.";
                          _errorStatus = true;
                          _buttonState = 'notloading';
                        });
                      } else {
                        print("[+] All fields filled.");
                      }

                      var usernameStatus = await checkusername(
                          _fnameController.text, _lnameController.text);
                      var emailStatus = await checkemail(_emailController.text);

                      if (usernameStatus == false) {
                        return setState(() {
                          _errorMessage =
                              "The username ${_fnameController.text} ${_lnameController.text} has already been taken.";
                          _errorStatus = true;
                          _buttonState = 'notloading';
                        });
                      }

                      if (emailStatus == false) {
                        return setState(() {
                          _errorMessage = "Your email has already been taken.";
                          _errorStatus = true;
                          _buttonState = 'notloading';
                        });
                      }

                      if (_passwordController.text != _confirmController.text) {
                        print('[----] Passwords dont match');
                        return setState(() {
                          _errorMessage = "Your passwords don\'t match!";
                          _errorStatus = true;
                          _buttonState = 'notloading';
                        });
                      } else {
                        print('[+] Passwords match!!!');

                        if (_passwordController.text == "password123" ||
                            _passwordController.text == "password") {
                          setState(() {
                            _buttonState = 'notloading';
                          });
                          FocusScope.of(context).requestFocus(FocusNode());
                          return _popup();
                        } else {
                          try {
                            bool createStatus = await createAccount(
                              _fnameController.text,
                              _lnameController.text,
                              "Hello, i love domestics",
                              "0000000000",
                              _passwordController.text,
                              _emailController.text,
                              "https://domestics.com",
                            );

                            switch (createStatus) {
                              case true:
                                print('[+] Created successfully.');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Setup()),
                                );
                                break;
                              default:
                                print('[--] Failed to create account');
                                break;
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
