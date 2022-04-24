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
                const SizedBox(height: 20.0),
                const Hero(
                  tag: 'logo',
                  child: Image(
                    image: AssetImage("assets/paw.png"),
                    height: 40.0,
                  ),
                ),
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
                  'Lets get you set up.',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'SFT-Regular',
                    color: dBlack,
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: dGreyFaded,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: CupertinoTextField(
                    scrollPhysics: const BouncingScrollPhysics(),
                    style: TextStyle(
                      color: dBlack,
                    ),
                    onSubmitted: (value) {},
                    decoration: const BoxDecoration(color: Colors.transparent),
                    maxLines: 1,
                    placeholder: 'Email Address',
                    placeholderStyle: TextStyle(color: dGrey),
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: dGreyFaded,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: CupertinoTextField(
                    obscureText: true,
                    scrollPhysics: const BouncingScrollPhysics(),
                    style: TextStyle(
                      color: dBlack,
                    ),
                    onSubmitted: (value) {},
                    decoration: const BoxDecoration(color: Colors.transparent),
                    maxLines: 1,
                    placeholder: 'Password',
                    placeholderStyle: TextStyle(color: dGrey),
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: dGreyFaded,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: CupertinoTextField(
                    obscureText: true,
                    scrollPhysics: const BouncingScrollPhysics(),
                    style: TextStyle(
                      color: dWhitePure,
                    ),
                    onSubmitted: (value) {},
                    decoration: const BoxDecoration(color: Colors.transparent),
                    maxLines: 1,
                    placeholder: 'Confirm password',
                    placeholderStyle: TextStyle(color: dGrey),
                  ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 2.0,
                      width: 60.0,
                      decoration: BoxDecoration(color: dWhitePure),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      'or register with',
                      style: TextStyle(
                          color: dBlack,
                          fontSize: 14.0,
                          fontFamily: 'SFT-Regular'),
                    ),
                    const SizedBox(width: 10.0),
                    Container(
                      height: 2.0,
                      width: 60.0,
                      decoration: BoxDecoration(color: dWhitePure),
                    )
                  ],
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _popup,
                      child: AuthBtn(
                        icon: FaIcon(
                          FontAwesomeIcons.facebook,
                          color: dBlack,
                          size: 24.0,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _popup,
                      child: AuthBtn(
                        icon: FaIcon(
                          FontAwesomeIcons.github,
                          color: dBlack,
                          size: 24.0,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _popup,
                      child: AuthBtn(
                        icon: FaIcon(
                          FontAwesomeIcons.google,
                          color: dBlack,
                          size: 24.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
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
