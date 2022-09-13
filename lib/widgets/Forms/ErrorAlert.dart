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
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(6.0),
        ),
        padding: EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, 
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 6.0,
              width: 6.0,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            SizedBox(width: 10.0),
            Flexible(
              child: Text(
                errorMessage,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
