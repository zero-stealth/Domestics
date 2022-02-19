import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Selections extends StatefulWidget {
  @override
  _SelectionsState createState() => _SelectionsState();
}

class _SelectionsState extends State<Selections> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffda4b2e),
      body: SafeArea(
          child: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 10.0),
                Container(
                  width: double.infinity,
                  height: 5.0,
                  decoration: BoxDecoration(
                    color: const Color(0xffcf3f23),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Who do you want to find?",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'SFD-Bold',
                    fontSize: 26.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      // runAlignment: WrapAlignment.start,
                      // crossAxisAlignment: WrapCrossAlignment.start,
                      runSpacing: 20.0,
                      spacing: 20.0,
                      children: [
                        Tab(text: 'Someone to talk to'),
                        Tab(text: 'Baby sitter'),
                        Tab(text: 'Doctor'),
                        Tab(text: 'Repair man'),
                        Tab(text: 'Tutor'),
                        Tab(text: 'Painter'),
                        Tab(text: 'Cleaner'),
                        Tab(text: 'IT support'),
                        Tab(text: 'Pet sitter'),
                        Tab(text: 'Cook'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
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
                  MaterialPageRoute(builder: (context) => Selections()),
                );
              },
            ),
          ),
        ),
      ])),
    );
  }
}

class Tab extends StatefulWidget {
  final String text;

  Tab({required this.text});

  @override
  State<Tab> createState() => _TabState();
}

class _TabState extends State<Tab> {
  Color highback = const Color(0xffcf3f23);
  Color hightext = Colors.white;
  bool highlighted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (highlighted == false) {
            highlighted = true;
            highback = Colors.white;
            hightext = const Color(0xffcf3f23);
          } else {
            highlighted = false;
            highback = const Color(0xffcf3f23);
            hightext = Colors.white;
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
          left: 30.0,
          right: 30.0,
        ),
        decoration: BoxDecoration(
          color: highback,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: hightext,
            fontSize: 16.0,
            fontFamily: 'SFT-Regular',
          ),
        ),
      ),
    );
  }
}