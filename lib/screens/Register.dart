import 'package:domestics/data/colors.dart';
import 'package:domestics/screens/Selections.dart';
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
  _loginModal(context) {
    showModalBottomSheet(
      backgroundColor: const Color(0xFFfdfbfa),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30.0),
              Text(
                'Login',
                style: TextStyle(
                  color: dBlack,
                  fontSize: 20.0,
                  fontFamily: 'SFD-Bold',
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Phone Number',
                style: TextStyle(
                  fontSize: 14.0,
                  color: dBlackFaded,
                  fontFamily: 'SFD-Bold',
                ),
              ),
              const SizedBox(height: 10.0),
              CupertinoTextField(
                onSubmitted: (value) {},
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.grey[100],
                ),
                maxLines: 1,
                padding: const EdgeInsets.all(14.0),
                placeholder: '0723442354',
                placeholderStyle: TextStyle(
                  color: Colors.black26,
                ),
              ),
              const SizedBox(height: 15.0),
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 14.0,
                  color: dBlack,
                  fontFamily: 'SFD-Bold',
                ),
              ),
              const SizedBox(height: 10.0),
              CupertinoTextField(
                onSubmitted: (value) {},
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.grey[100],
                ),
                maxLines: 1,
                padding: const EdgeInsets.all(14.0),
                placeholder: '*******',
                placeholderStyle: TextStyle(
                  color: Colors.black26,
                ),
              ),
              const SizedBox(height: 20.0),
              // ignore: sized_box_for_whitespace
              Container(
                width: double.infinity,
                child: CupertinoButton(
                  color: dBlack,
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'SFD-Bold'),
                  ),
                  onPressed: () {
                    _loginModal(context);
                  },
                ),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
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
                CupertinoTextField(
                  scrollPhysics: const BouncingScrollPhysics(),
                  style: TextStyle(
                    color: dBlack,
                  ),
                  onSubmitted: (value) {},
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1.0, color: dBlackFaded),
                  )),
                  maxLines: 1,
                  padding: const EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  placeholder: 'Email Address',
                  placeholderStyle: TextStyle(color: dBlackFaded),
                ),
                const SizedBox(height: 30.0),
                CupertinoTextField(
                  obscureText: true,
                  scrollPhysics: const BouncingScrollPhysics(),
                  style: TextStyle(
                    color: dBlack,
                  ),
                  onSubmitted: (value) {},
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1.0, color: dBlackFaded),
                  )),
                  maxLines: 1,
                  padding: const EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  placeholder: 'Password',
                  placeholderStyle: TextStyle(color: dBlackFaded),
                ),
                const SizedBox(height: 30.0),
                CupertinoTextField(
                  obscureText: true,
                  scrollPhysics: const BouncingScrollPhysics(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  onSubmitted: (value) {},
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1.0, color: dBlackFaded),
                  )),
                  maxLines: 1,
                  padding: const EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  placeholder: 'Confirm password',
                  placeholderStyle: TextStyle(color: dBlackFaded),
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
                    child: const Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
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
                      decoration: const BoxDecoration(color: Colors.white12),
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
                      decoration: const BoxDecoration(color: Colors.white12),
                    )
                  ],
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.facebook,
                        color: dBlack,
                        size: 24.0,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.github,
                        color: dBlack,
                        size: 24.0,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.google,
                        color: dBlack,
                        size: 24.0,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50.0),
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
