import 'package:domestics/data/colors.dart';
import 'package:domestics/screens/Register.dart';
import 'package:domestics/screens/Selections.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  _loginModal(context) {
    showModalBottomSheet(
      backgroundColor: dBackgroundWhite,
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
                  color: dGrey[100],
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
                  color: dGrey[100],
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
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: dWhitePure,
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
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: dGreyFaded,
                      borderRadius: BorderRadius.circular(6.0)),
                  child: CupertinoTextField(
                    scrollPhysics: const BouncingScrollPhysics(),
                    style: TextStyle(
                      color: dBlack,
                    ),
                    onSubmitted: (value) {},
                    decoration: const BoxDecoration(
                        color: Colors.transparent),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 2.0,
                      width: 60.0,
                      decoration: BoxDecoration(color: dGreyFaded),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      'or login with',
                      style: TextStyle(
                          color: dBlack,
                          fontSize: 14.0,
                          fontFamily: 'SFT-Regular'),
                    ),
                    const SizedBox(width: 10.0),
                    Container(
                      height: 2.0,
                      width: 60.0,
                      decoration: BoxDecoration(color: dGreyFaded),
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
                        color: dBackgroundWhite,
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
                        color: dBackgroundWhite,
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
                        color: dBackgroundWhite,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.google,
                        color: dBlack,
                        size: 24.0,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
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
