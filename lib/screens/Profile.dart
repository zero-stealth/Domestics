import 'dart:developer';
import 'dart:ffi';

import 'package:domestics/Functions/Utility.dart';
import 'package:domestics/Functions/http_service.dart';
import 'package:domestics/controllers/clients_controller.dart';
import 'package:domestics/data/colors.dart';
import 'package:domestics/widgets/Dashboard/Star.dart';
import 'package:domestics/widgets/TagsView.dart';
import 'package:domestics/widgets/TopControl.dart';
import 'package:domestics/widgets/settings/MyDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../Functions/SettingsFuncs.dart';

class Profile extends StatefulWidget {
  final String username;
  final String url;
  final tags;
  final String bio;
  final String minutesAway;
  final double starsCount;
  final reviews;
  final String location;
  final String userId;

  Profile({
    required this.username,
    required this.url,
    required this.tags,
    required this.bio,
    required this.minutesAway,
    required this.starsCount,
    required this.reviews,
    required this.location,
    required this.userId,
  });

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  showTags() {
    // log("LENGTH ${widget.tags.length}");

    for (var i = 0; i < widget.tags.length; i++) {
      // log(widget.tags[i]);
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
            widget.tags[i]['tag'],
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

  _referalModal(context, username) {
    var controller = Get.put(ClientsController());
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: dBackgroundWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: StatefulBuilder(
            builder: (
              BuildContext context,
              StateSetter setState,
            ) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50.0,
                              height: 4.0,
                              margin: EdgeInsets.only(top: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                color: const Color(0xff8e8e90).withOpacity(0.3),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          "Pick a client",
                          style: TextStyle(
                            fontFamily: 'AR',
                            color: Color(0xff262626),
                            fontSize: 22.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          "Select a client to refer to $username",
                          style: TextStyle(
                            fontFamily: 'SFNSR',
                            color: Color(0xff8e8e90),
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        for (var i in controller.clients)
                          i['prod_id'] == widget.userId
                              ? Container(height: 0.0)
                              : Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 0.0,
                                          right: 0.0,
                                          top: 15.0,
                                          bottom: 15.0),
                                      padding: EdgeInsets.all(0.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: const Color(0xfffafafa),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 60.0,
                                                height: 60.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      "$baseUrl/users/profileImage?id=${i['prod_id']}",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 18.0),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${capitalize('${i['fname']}')} ${capitalize('${i['lname']}')}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontFamily: 'AR',
                                                      color: Color(0xff262626),
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5.0),
                                                  Text(
                                                    "${i['bio']}",
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
                        const SizedBox(height: 30.0),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
    getAllUsers();
    super.initState();
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
              name: "Profile",
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
                                  "$baseUrl/users/profileImage?imageCode=${widget.url}",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                CupertinoIcons.location_fill,
                                size: 14.0,
                                color: dBlueBackground,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                widget.location,
                                style: TextStyle(
                                  fontFamily: 'AR',
                                  color: dBlueBackground,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                          RatingBar.builder(
                            unratedColor: dGreyFadedPlus,
                            initialRating: widget.starsCount,
                            ignoreGestures: true,
                            allowHalfRating: true,
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
                      TagsView(
                        tags: widget.tags,
                        showMark: false,
                      ),
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
                          child: InkWell(
                            onTap: () {
                              _referalModal(context, widget.username);
                            },
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
                          InkWell(
                            onTap: () {
                              reviewModal(context, widget.userId);
                            },
                            child: Text(
                              'Add a review',
                              style: TextStyle(
                                fontFamily: 'SFNSR',
                                color: dBlueBackground,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      widget.reviews.length == 0
                          ? Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      CupertinoIcons.chat_bubble,
                                      color: dGreyFaded,
                                      size: 60.0,
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "No reviews yet",
                                      style: TextStyle(
                                        color: dGrey,
                                        fontFamily: "SFSNR",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ReviewsContainer(
                              reviews: widget.reviews,
                            ),
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
  final reviews;

  ReviewsContainer({
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: dBackgroundWhite,
        border: Border.all(
          color: dGreyFaded,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i in reviews)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Review(
                username: i['username'],
                review: i["message"],
                ratingCount: double.parse(i["starsCount"]),
                totalReviewsCount: reviews.length,
                position: reviews.length,
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
  final double ratingCount;
  final int totalReviewsCount;
  final position;

  Review({
    required this.username,
    required this.review,
    required this.ratingCount,
    required this.totalReviewsCount,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RatingBar.builder(
            unratedColor: dGreyFadedPlus,
            allowHalfRating: true,
            initialRating: ratingCount,
            ignoreGestures: true,
            itemSize: 14.0,
            itemCount: 5,
            itemBuilder: (context, _) => Icon(
              CupertinoIcons.star_fill,
              color: Color(0xff278fe9),
            ),
            onRatingUpdate: (rating) {
              log("$rating");
            },
          ),
          const SizedBox(height: 8.0),
          Text(
            username,
            style: TextStyle(
              fontFamily: 'AR',
              color: Color(0xff262626),
              fontSize: 15.0,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            review,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'SFNSR',
              color: Color.fromARGB(255, 65, 65, 65),
              fontSize: 14.0,
            ),
          ),
          // position < totalReviewsCount ? MyDivider() : Container(),
        ],
      ),
    );
  }
}
