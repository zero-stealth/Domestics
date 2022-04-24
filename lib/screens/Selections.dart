import 'dart:developer';
import 'package:domestics/data/colors.dart';
import 'package:domestics/screens/Dashboard.dart';
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

  void _popup() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            title: 'Hello',
            content: 'Selecting categories will help you find workers easily.',
            continueWidget: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 80,
                  child: CupertinoButton(
                    padding: const EdgeInsets.all(10.0),
                    color: dBlueBackground,
                    child: const Text(
                      'Skip for now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'SFT-Regular',
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Dashboard()),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  width: MediaQuery.of(context).size.width - 80,
                  child: CupertinoButton(
                    padding: const EdgeInsets.all(10.0),
                    color: dGreyFaded,
                    child: Text(
                      'Back',
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
                    color: dGreyFaded,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: barWidth,
                        decoration: BoxDecoration(
                          color: dBlueBackground,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  "Who do you want to find?",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'SFD-Bold',
                    fontSize: 26.0,
                    color: dBlack,
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
              color: dBlueBackground,
              child: Text(
                'Continue',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontFamily: 'SFD-Bold'),
              ),
              onPressed: () {
                for (var m in selected) {
                  log(m);
                }

                if (selected.length < 1) {
                  _popup();
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
                  );
                }
              },
            ),
          ),
        ),
        // Dialog(status: true),
      ])),
    );
  }
}

class Dialog extends StatelessWidget {
  final String title;
  final String content;
  // final Widget cancelWidget;
  final Widget continueWidget;

  Dialog({
    required this.title,
    required this.content,
    // required this.cancelWidget,
    required this.continueWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 40,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: dBackgroundWhite,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'SFD-Bold',
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    color: dBlack,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  content,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'SFT-Regular',
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                    color: dBlack,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [continueWidget],
                ),
              ],
            ),
          )
        ],
      ),
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
  Color highback = dGreyFaded;
  Color hightext = dBlack;
  bool highlighted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (highlighted == false) {
            highlighted = true;
            widget.onSelect(true);
            highback = dBlueBackground;
            hightext = Colors.white;
          } else {
            highlighted = false;
            widget.onSelect(false);
            highback = dGreyFaded;
            hightext = dBlack;
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
