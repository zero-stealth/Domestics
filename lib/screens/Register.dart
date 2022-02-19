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
              const Text(
                'Login',
                style: TextStyle(
                  color: Color(0xffda4b2e),
                  fontSize: 20.0,
                  fontFamily: 'SFD-Bold',
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Phone Number',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xffda4b2e),
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
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xffda4b2e),
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
                  color: const Color(0xffda4b2e),
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
      backgroundColor: const Color(0xffda4b2e),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Hero(
                  tag: 'logo',
                  child: Image(
                    image: AssetImage("assets/paw.png"),
                    height: 30.0,
                  ),
                ),
                const SizedBox(height: 50.0),
                const Text(
                  'Welcome',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 26.0,
                    fontFamily: 'SFD-Bold',
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4.0),
                const Text(
                  'Lets get you set up.',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'SFT-Regular',
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30.0),
                CupertinoTextField(
                  scrollPhysics: const BouncingScrollPhysics(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  onSubmitted: (value) {},
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.white70),
                  )),
                  maxLines: 1,
                  padding: const EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  placeholder: 'Email Address',
                  placeholderStyle: const TextStyle(color: Colors.white54),
                ),
                const SizedBox(height: 30.0),
                CupertinoTextField(
                  obscureText: true,
                  scrollPhysics: const BouncingScrollPhysics(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  onSubmitted: (value) {},
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.white70),
                  )),
                  maxLines: 1,
                  padding: const EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  placeholder: 'Password',
                  placeholderStyle: const TextStyle(color: Colors.white54),
                ),
                const SizedBox(height: 30.0),
                CupertinoTextField(
                  obscureText: true,
                  scrollPhysics: const BouncingScrollPhysics(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  onSubmitted: (value) {},
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.white70),
                  )),
                  maxLines: 1,
                  padding: const EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  placeholder: 'Confirm password',
                  placeholderStyle: const TextStyle(color: Colors.white54),
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
                    color: Colors.white,
                    child: const Text(
                      'Register',
                      style: TextStyle(
                          color: Color(0xffda4b2e),
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
                    const Text(
                      'or register with',
                      style: TextStyle(
                          color: Colors.white,
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
                      child: const FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Color(0xffda4b2e),
                        size: 24.0,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.github,
                        color: Color(0xffda4b2e),
                        size: 24.0,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.google,
                        color: Color(0xffda4b2e),
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
                  child: const Center(
                    child: Text(
                      'Already have an account? Log in',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
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