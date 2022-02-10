import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'Login.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffda4b2e),
      body: SafeArea(
        child: Stack(children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              margin:
                  const EdgeInsets.only(bottom: 50.0, left: 35.0, right: 35.0),
              child: CupertinoButton(
                color: Colors.white,
                child: const Text(
                  'Continue',
                  style: TextStyle(
                      color: Color(0xffda4b2e),
                      fontSize: 16.0,
                      fontFamily: 'SFD-Bold'),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 50.0),
              child: Column(
                children: const [
                  Hero(
                    tag: 'logo',
                    child: Image(
                      image: AssetImage("assets/paw.png"),
                      height: 40.0,
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Text(
                    'What we do',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontFamily: 'SFT-Bold'),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: CarouselSlider(
              items: [
                Container(
                  margin: const EdgeInsets.all(6.0),
                  padding: const EdgeInsets.all(20.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage("assets/map.png"),
                        height: 200.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Access',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SFD-Bold',
                          color: Color(0xffda4b2e),
                          fontSize: 22.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Locate domestic workers in your area.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SFT-Regular',
                          color: Color(0xffda4b2e),
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(6.0),
                  padding: const EdgeInsets.all(20.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage("assets/verify.png"),
                        height: 130.0,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      const Text(
                        'Secure',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SFD-Bold',
                          color: Color(0xffda4b2e),
                          fontSize: 22.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Find help based on community reviews.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SFT-Regular',
                          color: Color(0xffda4b2e),
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              options: CarouselOptions(
                height: 400,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                // onPageChanged: callbackFunction,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
