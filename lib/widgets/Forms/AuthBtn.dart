import 'package:domestics/data/colors.dart';
import 'package:flutter/material.dart';

class AuthBtn extends StatelessWidget {
  final Widget icon;

  AuthBtn({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: dBackgroundWhite,
        ),
        child: icon);
  }
}
