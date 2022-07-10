import 'package:flutter/material.dart';

import '../data/colors.dart';

class MyDialog extends StatelessWidget {
  final String title;
  final String content;
  // final Widget cancelWidget;
  final Widget continueWidget;
  final Color backgroundColor;
  final Color textColor;

  MyDialog({
    required this.title,
    required this.content,
    // required this.cancelWidget,
    required this.continueWidget,
    required this.textColor,
    required this.backgroundColor,
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
              color: backgroundColor,
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
                    color: textColor,
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
                    color: textColor,
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