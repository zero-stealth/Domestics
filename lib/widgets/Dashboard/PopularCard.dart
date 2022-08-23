import 'package:domestics/screens/Profile.dart';
import 'package:flutter/material.dart';

class PopularCard extends StatelessWidget {
  final List<String> tags;
  final String url;
  final String fname;
  final String minutesAway;
  final String bio;

  PopularCard({
    required this.tags,
    required this.url,
    required this.fname,
    required this.minutesAway,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(
              username: fname,
              tags: tags,
              url: url,
              minutesAway: minutesAway,
              bio: bio,
            ),
          ),
        );
      },
      child: Column(
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
                        color: const Color(0xff278fe9),
                        borderRadius: BorderRadius.circular(50.0),
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
                            tags[0],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontFamily: 'AR',
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
              fontFamily: 'AR',
              color: Color(0xff262626),
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            minutesAway,
            style: TextStyle(
              fontFamily: 'SFNSR',
              color: Color(0xff262626),
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
