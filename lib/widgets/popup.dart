import 'package:domestics/widgets/Dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/colors.dart';

// class Popup extends StatelessWidget {
//   final String title;
//   final String content;
//   final String mainButtonText;
//   final String otherButtonText;
//   final Function mainButtonClicked;
//   final Function otherButtonClicked;

//   Popup({
//     required this.title,
//     required this.content,
//     required this.mainButtonText,
//     required this.otherButtonClicked,
//     required this.mainButtonClicked,
//     required this.otherButtonText
//   })

//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }

Future<dynamic> popup(
  context,
  String title,
  String content,
  Widget actionsWidget,
  Color backgroundColor,
  Color textColor,
) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return MyDialog(
          title: title,
          content: content,
          continueWidget: actionsWidget,
          textColor: textColor,
          backgroundColor: backgroundColor,
        );
      });
}
