import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/colors.dart';

class InputWidget extends StatefulWidget {
  final String label;
  final String placeholder;
  final TextEditingController mycontroller;
  final bool obscure;

  InputWidget({
    required this.label,
    required this.placeholder,
    required this.mycontroller,
    required this.obscure,
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: dBlack,
            fontSize: 12.0,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: dGreyFaded,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: CupertinoTextField(
            obscureText: widget.obscure,
            controller: widget.mycontroller,
            scrollPhysics: const BouncingScrollPhysics(),
            style: TextStyle(
              color: dBlack,
            ),
            onChanged: (text) {
              // print(text);
            },
            decoration: const BoxDecoration(color: Colors.transparent),
            maxLines: 1,
            placeholder: widget.placeholder,
            placeholderStyle: TextStyle(color: dGrey),
          ),
        ),
      ],
    );
  }
}
