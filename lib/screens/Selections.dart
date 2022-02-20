import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Selections extends StatefulWidget {
  @override
  _SelectionsState createState() => _SelectionsState();
}

class _SelectionsState extends State<Selections> {
  // Contains values of all selected tabs
  List selected = [];
  // width of top progress bar
  var barWidth;
  // 25% of the total width of the barWidth at max width
  var value;

  // Adds and removes values inside the selected list
  selectedHandler(text, status) {
    if (status == false) {
      for (var i = 0; i < selected.length; i++) {
        if (selected[i] == text) {
          selected.removeAt(i);
        }
      }

      setState(() {
        if (selected.length < 4) {
          value = ((MediaQuery.of(context).size.width - 40) * 25) / 100;
          barWidth = barWidth - value;
        }
      });
    } else {
      selected.add(text);

      // calculate bar width when an element is added to the selected list
      // MediaQuery.of(context).size.width - 40; is the maximum width of the bar
      setState(() {
        if (selected.length >= 4) {
          barWidth = MediaQuery.of(context).size.width - 40;
        } else {
          barWidth =
              ((MediaQuery.of(context).size.width - 40) * getPercentage()) /
                  100;
        }
      });
    }
  }

  // returns the percentage length of the bar
  // based on how many items are in the 
  // selected list
  getPercentage() {
    switch (selected.length) {
      case 1:
        return 25;
        break;

      case 2:
        return 50;
        break;

      case 3:
        return 75;
        break;

      case 4:
        return 100;
        break;
      default:
        return 0;
    }
  }

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
                        width: barWidth,
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
                        Tab(
                          text: 'Someone to talk to',
                          onSelect: (selectedStatus) {
                            selectedHandler(
                                'Someone to talk to', selectedStatus);
                          },
                        ),
                        Tab(
                          text: 'Baby sitter',
                          onSelect: (selectedStatus) {
                            selectedHandler('Baby sitter', selectedStatus);
                          },
                        ),
                        Tab(
                          text: 'Doctor',
                          onSelect: (selectedStatus) {
                            selectedHandler('Doctor', selectedStatus);
                          },
                        ),
                        Tab(
                          text: 'Repair man',
                          onSelect: (selectedStatus) {
                            selectedHandler('Repair man', selectedStatus);
                          },
                        ),
                        Tab(
                          text: 'Tutor',
                          onSelect: (selectedStatus) {
                            selectedHandler('Tutor', selectedStatus);
                          },
                        ),
                        Tab(
                          text: 'Painter',
                          onSelect: (selectedStatus) {
                            selectedHandler('Painter', selectedStatus);
                          },
                        ),
                        Tab(
                          text: 'Cleaner',
                          onSelect: (selectedStatus) {
                            selectedHandler('Cleaner', selectedStatus);
                          },
                        ),
                        Tab(
                          text: 'IT support',
                          onSelect: (selectedStatus) {
                            selectedHandler('IT support', selectedStatus);
                          },
                        ),
                        Tab(
                          text: 'Pet sitter',
                          onSelect: (selectedStatus) {
                            selectedHandler('Pet sitter', selectedStatus);
                          },
                        ),
                        Tab(
                          text: 'Cook',
                          onSelect: (selectedStatus) {
                            selectedHandler('Cook', selectedStatus);
                          },
                        ),
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Selections()),
                // );
                for (var m in selected) {
                  log(m);
                }
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
  final Function(bool) onSelect;

  Tab({required this.text, required this.onSelect});

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
            widget.onSelect(true);
            highback = Colors.white;
            hightext = const Color(0xffcf3f23);
          } else {
            highlighted = false;
            widget.onSelect(false);
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
