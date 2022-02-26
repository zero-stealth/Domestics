import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Star extends StatelessWidget {
  const Star({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 4.0,
      ),
      child: Icon(
        CupertinoIcons.star_fill,
        color: Colors.orangeAccent,
        size: 14.0,
      ),
    );
  }
}