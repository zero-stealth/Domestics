import 'package:flutter/material.dart';

class UserTab extends StatelessWidget {
  final String fname;
  final String tag;
  final String url;

  UserTab({ 
    required this.fname,
    required this.tag,
    required this.url
   });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        bottom: 15.0,
      ),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xfffafafa),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      url,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 18.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    tag,
                    style: TextStyle(
                      fontFamily: 'SFT-Regular',
                      color: Color(0xff262626),
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}