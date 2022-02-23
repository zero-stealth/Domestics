import 'package:flutter/material.dart';

class PopularCard extends StatelessWidget {
  final String tag;
  final String url;
  final String fname;
  final String minutesAway;

  PopularCard({
    required this.tag,
    required this.url,
    required this.fname,
    required this.minutesAway,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            right: 20.0,
          ),
          width: 230.0,
          height: 150.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                url,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 6.0,
                      bottom: 6.0,
                      left: 12.0,
                      right: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xfffafafa).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(
                        //   CupertinoIcons.star_fill,
                        //   size: 12.0,
                        //   color: Color(0xff262626),
                        // ),
                        const SizedBox(width: 6.0),
                        Text(
                          tag,
                          style: TextStyle(
                            color: Color(0xff262626),
                            fontSize: 12.0,
                            fontFamily: 'SFD-Bold',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        Text(
          fname,
          style: TextStyle(
            fontFamily: 'SFD-Bold',
            color: Color(0xff262626),
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          minutesAway,
          style: TextStyle(
            fontFamily: 'SFT-Regular',
            color: Color(0xff262626),
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}
