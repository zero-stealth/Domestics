import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/colors.dart';

class NumberInput extends StatefulWidget {
  final String label;
  final String placeholder;
  final TextEditingController mycontroller;
  final bool obscure;

  NumberInput({
    required this.label,
    required this.placeholder,
    required this.mycontroller,
    required this.obscure,
  });

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
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
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: dGreyFaded,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: CupertinoTextField(
            prefix: Container(
              margin: EdgeInsets.only(right: 10.0),
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: dBlueBackground,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                "+254",
                style: TextStyle(
                  fontSize: 16.0,
                  color: dWhitePure,
                  fontFamily: 'SFD-Bold',
                ),
              ),
            ),
            keyboardType: TextInputType.number,
            autofocus: true,
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
            placeholderStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
          ),
        ),
      ],
    );
  }
}
