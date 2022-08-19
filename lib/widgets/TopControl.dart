import 'package:domestics/data/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopControl extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color backgroundColor;

  TopControl({
    required this.name,
    required this.icon,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0.0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      actions: [],
      leading: Padding(
        padding: EdgeInsets.only(
          left: 5.0,
          top: 10.0,
        ),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            icon,
            size: 24.0,
            color: Color(0xff262626),
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
        ),
        child: Text(
          name,
          style: TextStyle(
            fontFamily: 'AR',
            color: Color(0xff262626),
            fontSize: 18.0,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      // expandedHeight: 100.0,
      floating: true,
      pinned: false,
    );
  }
}
