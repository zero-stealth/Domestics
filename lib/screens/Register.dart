import 'package:domestics/data/colors.dart';
import 'package:domestics/screens/Selections.dart';
import 'package:domestics/widgets/Dialog.dart';
import 'package:domestics/widgets/Forms/AuthBtn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                // const SizedBox(height: 20.0),
                // const Hero(
                //   tag: 'logo',
                //   child: Image(
                //     image: AssetImage("assets/paw.png"),
                //     height: 40.0,
                //   ),
                // ),
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
                const SizedBox(height: 25.0),
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
                      'Register',
                      style: TextStyle(
                          color: dWhitePure,
                          fontSize: 16.0,
                          fontFamily: 'SFD-Bold'),
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Container(
                //       height: 2.0,
                //       width: 60.0,
                //       decoration: BoxDecoration(color: dWhitePure),
                //     ),
                //     const SizedBox(width: 10.0),
                //     Text(
                //       'or register with',
                //       style: TextStyle(
                //           color: dBlack,
                //           fontSize: 14.0,
                //           fontFamily: 'SFT-Regular'),
                //     ),
                //     const SizedBox(width: 10.0),
                //     Container(
                //       height: 2.0,
                //       width: 60.0,
                //       decoration: BoxDecoration(color: dWhitePure),
                //     )
                //   ],
                // ),
                // const SizedBox(height: 30.0),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: _popup,
                //       child: AuthBtn(
                //         icon: FaIcon(
                //           FontAwesomeIcons.facebook,
                //           color: dBlack,
                //           size: 24.0,
                //         ),
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: _popup,
                //       child: AuthBtn(
                //         icon: FaIcon(
                //           FontAwesomeIcons.github,
                //           color: dBlack,
                //           size: 24.0,
                //         ),
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: _popup,
                //       child: AuthBtn(
                //         icon: FaIcon(
                //           FontAwesomeIcons.google,
                //           color: dBlack,
                //           size: 24.0,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 10.0),
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
                      style: TextStyle(color: dBlack, fontSize: 16.0),
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

class InputWidget extends StatefulWidget {
  final String label;
  final String placeholder;
  final TextEditingController mycontroller;
  final bool obscure;

  InputWidget({
    required this.label,
    required this.placeholder,
    required this.mycontroller,
    required this.obscure,
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: dBlack,
            fontSize: 12.0,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: dGreyFaded,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: CupertinoTextField(
            obscureText: widget.obscure,
            controller: widget.mycontroller,
            scrollPhysics: const BouncingScrollPhysics(),
            style: TextStyle(
              color: dBlack,
            ),
            onChanged: (text) {
              print(text);
            },
            decoration: const BoxDecoration(color: Colors.transparent),
            maxLines: 1,
            placeholder: widget.placeholder,
            placeholderStyle: TextStyle(color: dGrey),
          ),
        ),
      ],
    );
  }
}
