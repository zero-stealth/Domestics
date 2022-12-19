import 'dart:developer';
import 'dart:ui';
import 'package:domestics/Functions/http_service.dart';
import 'package:domestics/controllers/user_controller.dart';
import 'package:domestics/data/colors.dart';
import 'package:domestics/database/database_helper.dart';
import 'package:domestics/screens/Notifications.dart';
import 'package:domestics/screens/Settings.dart';
import 'package:domestics/widgets/Dashboard/PopularCard.dart';
import 'package:domestics/widgets/Dashboard/UserTab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

import '../controllers/workers_controller.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var controller = Get.put(WorkersController());
  var userController = Get.put(UserController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  late GlobalKey<ScaffoldState> _scaffoldKey;
  late List<String> _demoData;

  final _dbHelper = DatabaseHelper.instance;
  var _allWorkers = [];
  var _tags = [];

  @override
  void initState() {
    // getWorkers();
    _demoData = [
      "Flutter",
    ];
    _scaffoldKey = GlobalKey();
    _workers();
    super.initState();
    // _workers();
  }

  notifyBell() {
    for (var i = 0; i < userController.user[0]['notifications'].length; i++) {
      if (userController.user[0]['notifications'][i]['read'] == false) {
        return dBlueBackground;
      }
    }

    return dBlack;
  }

  // stuff() async {
  //   await getPosts();
  // }
  _workers() async {
    var workers = await _dbHelper.queryAllRows("workers");
    var workertags = await getAllTags();

    setState(() {
      _allWorkers = workers;
      _tags = workertags;
    });
  }

  _popular() {
    if (controller.workers.isEmpty) {
      return Text("nothing");
    } else {
      // for (var i = 0; i < controller.workers.length; i++) {
      //   return PopularCard(
      //     tags: controller.workers[i]['tags'][0],
      //     url: controller.workers[i]['imageUrl'],
      //     fname: controller.workers[i]['fname'],
      //     lname: controller.workers[i]['lname'],
      //     minutesAway: "2 mins away",
      //     bio: controller.workers[i]['bio'],
      //   );
      // }

      return Obx(
        () => Container(
          // padding: EdgeInsets.only(left: 20.0, right: 20.0),
          height: 240.0,
          child: controller.workers.length == 0
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Loader(),
                )
              : Obx(
                  () => ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: controller.workers.length,
                      itemBuilder: (_, index) {
                        log('${controller.workers.length}');
                        return PopularCard(
                          userId: controller.workers[index]['prod_id'],
                          tags: controller.workers[index]['tags'],
                          url: controller.workers[index]['imageUrl'],
                          fname: controller.workers[index]['fname'],
                          lname: controller.workers[index]['lname'],
                          minutesAway: "2 mins away",
                          bio: controller.workers[index]['bio'],
                          phone: controller.workers[index]['phone'],
                          location: controller.workers[index]['location'],
                          starsCount: controller.workers[index]['starsCount'],
                          reviews: controller.workers[index]['reviews'],
                        );
                      }),
                ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // backgroundColor: const Color(0xffefefef),
        backgroundColor: dBackgroundWhite,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: dBackgroundWhite,
            statusBarIconBrightness: Brightness.dark,
          ),
          leadingWidth: 2.0,
          leading: Container(),
          backgroundColor: dBackgroundWhite,
          elevation: 0.0,
          centerTitle: false,
          title: Text(
            'Domestics',
            style: TextStyle(
              fontFamily: 'AR',
              color: dBlack,
              fontSize: 20.0,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                top: 0.0,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Notifications()),
                  );
                },
                child: Icon(
                  CupertinoIcons.bell,
                  // notifyBell() == dBlack
                  //     ? CupertinoIcons.bell
                  //     : CupertinoIcons.bell_fill,
                  color: dBlack,
                  size: 25.0,
                ),
              ),
            ),
            const SizedBox(width: 28.0),
            Padding(
              padding: const EdgeInsets.only(
                top: 0.0,
                right: 20.0,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings()),
                  );

                  // Get.to(Settings());
                },
                child: Icon(
                  CupertinoIcons.settings_solid,
                  color: dBlack,
                  size: 25.0,
                ),
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          color: dBlueBackground,
          backgroundColor: dBackgroundWhite,
          onRefresh: () async {
            return Future.delayed(
              Duration(seconds: 1),
              () async {
                await populateData();
                await getWorkers();
                await getAllUsers();
                // setState(() {});
                // showing snackbar
              },
            );
          },
          child: ListView.builder(
            itemBuilder: (ctx, idx) {
              // List Item
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: controller.workers.length == 0 ||
                        controller.workers.length == null
                    ? Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Loader(),
                            Loader(),
                            Loader(),
                            Loader(),
                          ],
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // for (var i in posts)
                          //   DashboardItem(
                          //     tag: i['tag'],
                          //     fname: i['fname'],
                          //     minutesAway: i['minutesAway'],
                          //     url: i['url'],
                          //     stars: i['stars']
                          //   ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5.0,
                              left: 20.0,
                              right: 20.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Popular Nearby',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'AR',
                                    color: dBlack,
                                    fontSize: 14.0,
                                  ),
                                ),
                                // Icon(
                                //   CupertinoIcons.arrow_right,
                                //   size: 20.0,
                                //   color: dBlack,
                                // ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          _popular(),
                          SizedBox(height: 30.0),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              right: 20.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Recommended',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'AR',
                                    color: dBlack,
                                    fontSize: 14.0,
                                  ),
                                ),
                                // Icon(
                                //   CupertinoIcons.arrow_right,
                                //   size: 20.0,
                                //   color: dBlack,
                                // ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 0.0),
                          Container(
                            margin: const EdgeInsets.all(0.0),
                            padding: const EdgeInsets.only(
                              top: 5.0,
                              bottom: 10.0,
                            ),
                            decoration: BoxDecoration(
                              color: dBackgroundWhite,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: controller.workers.length == 0
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Loader(),
                                  )
                                : Obx(
                                    () => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        for (var i in controller.workers)
                                          UserTab(
                                            fname: i['fname'],
                                            lname: i['lname'],
                                            tags: i['tags'],
                                            url: i['imageUrl'],
                                            bio: i['bio'],
                                            minutesAway: "2",
                                            starsCount: i['starsCount'],
                                            phone: i['phone'],
                                            location: i['location'],
                                            reviews: i['reviews'],
                                            userId: i['prod_id'],
                                          ),
                                      ],
                                    ),
                                  ),
                          ),
                          SizedBox(height: 50.0),
                        ],
                      ),
              );
            },

            // Length of the list
            itemCount: _demoData.length,

            // To make listView scrollable
            // even if there is only a single item.
            physics: const AlwaysScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }
}

class Loader extends StatelessWidget {
  const Loader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
      child: Column(
        children: [
          SkeletonParagraph(
            style: SkeletonParagraphStyle(
              lines: 2,
              spacing: 5.0,
              lineStyle: SkeletonLineStyle(
                  randomLength: true,
                  height: 10.0,
                  borderRadius: BorderRadius.circular(50.0),
                  maxLength: MediaQuery.of(context).size.width - 150),
            ),
          ),
          SizedBox(height: 10.0),
          SkeletonItem(
            child: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: double.infinity,
                borderRadius: BorderRadius.circular(6.0),
                height: 100.0,
              ),
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
