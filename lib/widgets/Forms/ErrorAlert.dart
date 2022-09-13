import 'package:domestics/data/colors.dart';
import 'package:flutter/material.dart';

class ErrorAlert extends StatelessWidget {
  final String errorMessage;
  final bool status;

  ErrorAlert({
    required this.errorMessage,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    if (status == true) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(6.0),
        ),
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: Text(
            errorMessage,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.redAccent,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
