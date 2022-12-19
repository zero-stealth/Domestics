import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:domestics/Functions/Utility.dart';
import 'package:domestics/data/colors.dart';
import 'package:domestics/screens/Profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UserTab extends StatelessWidget {
  final String fname;
  final String lname;
  final tags;
  final String url;
  final String bio;
  final String minutesAway;
  final double starsCount;
  final reviews;
  final String location;
  final String userId;
  final String phone;

  UserTab({
    required this.fname,
    required this.lname,
    required this.tags,
    required this.url,
    required this.bio,
    required this.minutesAway,
    required this.starsCount,
    required this.reviews,
    required this.location,
    required this.userId,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(
              username: "${capitalize(fname)} ${capitalize(lname)}",
              tags: tags,
              url: url,
              minutesAway: minutesAway,
              bio: bio,
              starsCount: starsCount,
              reviews: reviews,
              location: location,
              userId: userId,
              phone: phone,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
            padding: EdgeInsets.all(0.0),
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
                        borderRadius: BorderRadius.circular(50.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "$baseUrl/users/profileImage?imageCode=$url",
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          fname == "lewis" && lname == ".n"
                              ? Container(
                                  padding: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: dBackgroundWhite,
                                  ),
                                  child: Icon(
                                    CupertinoIcons.checkmark_seal_fill,
                                    size: 16.0,
                                    color: Colors.green,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 190,
                              child: Text(
                                "${capitalize('$fname')} ${capitalize('$lname')}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'AR',
                                  color: Color(0xff262626),
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            RatingBar.builder(
                              allowHalfRating: true,
                              unratedColor: dGreyFadedPlus,
                              initialRating: starsCount,
                              itemSize: 14.0,
                              itemCount: 5,
                              updateOnDrag: false,
                              itemBuilder: (context, _) => Icon(
                                CupertinoIcons.star_fill,
                                color: Color(0xff278fe9),
                              ),
                              onRatingUpdate: (rating) {
                                log("$rating");
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          tags[0]['tag'],
                          style: TextStyle(
                            fontFamily: 'SFNSR',
                            color: dGrey,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
