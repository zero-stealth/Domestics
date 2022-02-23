import 'package:domestics/widgets/Dashboard/Star.dart';
import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  final String tag;
  final String fname;
  final String minutesAway;
  final String url;
  final int stars;

  DashboardItem({
    required this.tag,
    required this.fname,
    required this.minutesAway,
    required this.url,
    required this.stars
  });

  calculateStars(n) {
    switch (n) {
      case 1:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Star(),
          ],
        );

      case 2:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Star(),
            const Star(),
          ],
        );

      case 3:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Star(),
            const Star(),
            const Star(),
          ],
        );

      case 4:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Star(),
            const Star(),
            const Star(),
            const Star(),
          ],
        );
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 30.0,
      ),
      height: 230.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            url,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: const Color(0xfffafafa).withOpacity(0.85),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            child: Text(
                              fname,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0xff262626),
                                fontSize: 16.0,
                                fontFamily: 'SFD-Bold',
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '$stars.0',
                          style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 16.0,
                            fontFamily: 'SFD-Bold',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          minutesAway,
                          style: TextStyle(
                            color: Color(0xff262626),
                            fontSize: 14.0,
                            fontFamily: 'SFT-Regular',
                          ),
                        ),
                        calculateStars(stars),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}