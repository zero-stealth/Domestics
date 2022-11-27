import 'dart:developer';
import 'dart:ffi';

import 'package:domestics/data/colors.dart';
import 'package:domestics/widgets/Dashboard/Star.dart';
import 'package:domestics/widgets/TagsView.dart';
import 'package:domestics/widgets/TopControl.dart';
import 'package:domestics/widgets/settings/MyDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Profile extends StatefulWidget {
  final String username;
  final String url;
  final tags;
  final String bio;
  final String minutesAway;

  Profile({
    required this.username,
    required this.url,
    required this.tags,
    required this.bio,
    required this.minutesAway,
  });

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  showTags() {
    log("LENGTH ${widget.tags.length}");

    for (var i = 0; i < widget.tags.length; i++) {
      log(widget.tags[i]);
      return Container(
        margin: EdgeInsets.only(
          right: 10.0,
        ),
        padding: const EdgeInsets.only(
          top: 6.0,
          bottom: 6.0,
          left: 20.0,
          right: 20.0,
        ),
        decoration: BoxDecoration(
          color: const Color(0xff8e8e90).withOpacity(0.1),
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Center(
          child: Text(
            widget.tags[i],
            style: TextStyle(
              fontFamily: 'SFNSR',
              color: Color(0xff262626),
              fontSize: 14.0,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffefefef),
      backgroundColor: dBackgroundWhite,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            TopControl(
              name: "Dashboard",
              icon: CupertinoIcons.chevron_back,
              backgroundColor: dBackgroundWhite,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 20.0,
                    right: 20.0,
                    bottom: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: 200.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  widget.url,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Star(),
                          const Star(),
                          const Star(),
                          const Star(),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        widget.minutesAway,
                        style: TextStyle(
                          fontFamily: 'AR',
                          color: Color(0xff262626),
                          fontSize: 12.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        widget.username,
                        style: TextStyle(
                          fontFamily: 'AR',
                          color: Color(0xff262626),
                          fontSize: 22.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        widget.bio,
                        style: TextStyle(
                          fontFamily: 'SFNSR',
                          color: Color(0xff262626),
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TagsView(tags: widget.tags, showMark: false,),
                      const SizedBox(height: 20.0),
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: (MediaQuery.of(context).size.width - 40),
                              child: CupertinoButton(
                                padding: const EdgeInsets.only(
                                  top: 12.0,
                                  bottom: 12.0,
                                  left: 0.0,
                                  right: 0.0,
                                ),
                                color: dBlueBackground,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.phone_fill,
                                      color: dWhitePure,
                                      size: 18.0,
                                    ),
                                    const SizedBox(width: 15.0),
                                    Text(
                                      'Call me',
                                      style: TextStyle(
                                        fontFamily: 'AR',
                                        color: dWhitePure,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => Selections()),
                                  // );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        width: (MediaQuery.of(context).size.width - 40),
                        child: CupertinoButton(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                            left: 0.0,
                            right: 0.0,
                          ),
                          color: dBackgroundWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(
                              //   CupertinoIcons.bookmark,
                              //   color: dBlack,
                              //   size: 18.0,
                              // ),
                              // const SizedBox(width: 15.0),
                              Text(
                                'Refer me to someone',
                                style: TextStyle(
                                  fontFamily: 'SFNSR',
                                  color: dBlueBackground,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => Selections()),
                            // );
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Reviews',
                            style: TextStyle(
                              fontFamily: 'AR',
                              color: Color(0xff262626),
                              fontSize: 14.0,
                            ),
                          ),
                           Text(
                            'Add a review',
                            style: TextStyle(
                              fontFamily: 'SFNSR',
                              color: dBlueBackground,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      ReviewsContainer(),
                      const SizedBox(height: 80.0),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewsContainer extends StatelessWidget {
  const ReviewsContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: dBackgroundWhite,
        border: Border.all(
          color: dGreyFaded,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Review(
              username: "Piko",
              review: "Hated your services",
              ratingCount: 2,
            ),
          ),
          MyDivider(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Review(
              username: "Piko",
              ratingCount: 2,
              review: "Hated your services",
            ),
          ),
          MyDivider(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Review(
              username: "Piko",
              ratingCount: 4,
              review: "Hated your services",
            ),
          ),
        ],
      ),
    );
  }
}

class Review extends StatelessWidget {
  final String username;
  final String review;
  final int ratingCount;

  Review({ required this.username, required this.review, required this.ratingCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingBar.builder(
          unratedColor: dGreyFadedPlus,
          initialRating: 4, 
          itemSize: 14.0,
          itemCount: ratingCount,
          itemBuilder: (context, _) => Icon(
            CupertinoIcons.star_fill,
            color: Color(0xff278fe9),
          ),
          onRatingUpdate: (rating){
            log("$rating");
          },
        ),
        const SizedBox(height: 8.0),
        Text(
          username,
          style: TextStyle(
            fontFamily: 'AR',
            color: Color(0xff262626),
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          review,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'SFNSR',
            color: Color(0xff262626),
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}

