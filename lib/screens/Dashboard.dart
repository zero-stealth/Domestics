import 'dart:developer';
import 'dart:ui';
import 'package:domestics/Functions/http_service.dart';
import 'package:domestics/data/colors.dart';
import 'package:domestics/database/database_helper.dart';
import 'package:domestics/screens/Notifications.dart';
import 'package:domestics/screens/Settings.dart';
import 'package:domestics/widgets/Dashboard/PopularCard.dart';
import 'package:domestics/widgets/Dashboard/UserTab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _dbHelper = DatabaseHelper.instance;
  List posts = [
    {
      'tags': [
        {"tag": "Thief"},
        {"tag": "Hunter"},
        {"tag": "Dealer"},
      ],
      'fname': 'Levin Adams',
      'minutesAway': '2 min away',
      'stars': 4,
      'bio':
          'Hello, i am a tutor in nairobi contact me for business and enquiries.',
      'url':
          'https://images.unsplash.com/photo-1529390079861-591de354faf5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8YmxhY2slMjB0ZWFjaGVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    },
    {
      'tags': [
        {"tag": "Thief"},
        {"tag": "Hunter"},
        {"tag": "Dealer"},
      ],
      'fname': 'Lily Colt',
      'stars': 2,
      'minutesAway': '1 min away',
      'bio':
          'Hello, i am a painter in nairobi contact me for business and enquiries.',
      'url':
          'https://images.unsplash.com/photo-1510832842230-87253f48d74f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGFpbnRpbmd8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
    },
    {
      'tags': [
        {"tag": "Thief"},
        {"tag": "Hunter"},
        {"tag": "Dealer"},
      ],
      'fname': 'Sarah Payne',
      'stars': 1,
      'minutesAway': '1 min away',
      'bio':
          'Hello, i am a baby sitter and pet sitter in nairobi contact me for business and enquiries.',
      'url':
          'https://images.unsplash.com/photo-1534806391029-791d2695c38b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmxhY2slMjBiYWJ5fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    },
    {
      'tags': [
        {"tag": "Thief"},
        {"tag": "Hunter"},
        {"tag": "Dealer"},
      ],
      'fname': 'Brad Philips',
      'stars': 4,
      'minutesAway': '1 min away',
      'bio':
          'Hello, i am a mechanic in nairobi contact me for business and enquiries.',
      'url':
          'https://images.unsplash.com/photo-1583954964358-1bd7215b6f7a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8YmxhY2slMjBlbGVjdHJpY2lhbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    },
    {
      'tags': [
        {"tag": "Thief"},
        {"tag": "Hunter"},
        {"tag": "Dealer"},
      ],
      'fname': 'Karl Gibson',
      'stars': 3,
      'minutesAway': '1 min away',
      'bio':
          'Hello, i am a electrician in nairobi contact me for business and enquiries.',
      'url':
          'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8YmxhY2slMjBlbGVjdHJpY2lhbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    },
    {
      'tags': [
        {"tag": "Thief"},
        {"tag": "Hunter"},
        {"tag": "Dealer"},
      ],
      'fname': 'Colleen',
      'stars': 4,
      'minutesAway': '1 min away',
      'bio':
          'Hello, i am an IT support in nairobi contact me for business and enquiries.',
      'url':
          'https://images.unsplash.com/photo-1617042375876-a13e36732a04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8YmxhY2slMjBwcm9ncmFtbWVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    },
  ];
  var _allWorkers = [];
  var _tags = [];

  @override
  void initState() {
    super.initState();
    // stuff();
    _workers();
    getWorkers();
    _workers();
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
    if (_allWorkers.length <= 0 || _tags.length <= 0) {
      log("TAGS $_tags");
      return Text("nothing");
    } else {
      for (var i = 0; i < _allWorkers.length; i++) {
        return PopularCard(
          tags: _tags[i]["tags"],
          url: _allWorkers[i]["imageUrl"],
          fname: _allWorkers[i]["fname"],
          lname: _allWorkers[i]["lname"],
          minutesAway: "2 mins away",
          bio: _allWorkers[i]["bio"],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // backgroundColor: const Color(0xffefefef),
        backgroundColor: dBackgroundWhite,
        body: Stack(children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: dBackgroundWhite,
                  statusBarIconBrightness: Brightness.dark,
                ),
                elevation: 0.0,
                centerTitle: false,
                automaticallyImplyLeading: false,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Notifications()),
                        );
                      },
                      child: Icon(
                        CupertinoIcons.bell,
                        color: dBlack,
                        size: 25.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 32.0),
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
                      },
                      child: Icon(
                        CupertinoIcons.settings_solid,
                        color: dBlack,
                        size: 25.0,
                      ),
                    ),
                  )
                ],
                title: Padding(
                  padding: const EdgeInsets.only(
                    top: 0.0,
                    left: 5.0,
                  ),
                  child: Text(
                    'Domestics',
                    style: TextStyle(
                      fontFamily: 'AR',
                      color: dBlack,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                backgroundColor: dBackgroundWhite,
                // expandedHeight: 100.0,
                floating: true,
                pinned: false,
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Column(
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
                      const SizedBox(height: 26.0),
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _popular(),
                          ],
                        ),
                      ),
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
                          top: 10.0,
                          bottom: 10.0,
                        ),
                        decoration: BoxDecoration(
                          color: dBackgroundWhite,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var i in posts)
                              UserTab(
                                fname: i['fname'],
                                tags: i['tags'],
                                url: i['url'],
                                bio: i['bio'],
                                minutesAway: i['minutesAway'],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50.0),
                    ],
                  ),
                ]),
              ),
            ],
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: ClipRRect(
          //     child: BackdropFilter(
          //       filter: ImageFilter.blur(
          //         sigmaX: 3,
          //         sigmaY: 3,
          //       ),
          //       child: Container(
          //         padding: const EdgeInsets.only(
          //           top: 12.0,
          //           bottom: 12.0,
          //           left: 30.0,
          //           right: 30.0,
          //         ),
          //         width: double.infinity,
          //         decoration: BoxDecoration(
          //           border: Border(
          //             top: BorderSide(
          //               width: 1,
          //               color: Color(0xff8e8e90).withOpacity(0.1),
          //             ),
          //           ),
          //           gradient: LinearGradient(
          //             colors: [
          //               dBackgroundWhite.withOpacity(0.9),
          //               dBackgroundWhite.withOpacity(0.9),
          //             ],
          //             begin: AlignmentDirectional.topStart,
          //             end: AlignmentDirectional.bottomEnd,
          //           ),
          //         ),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Icon(CupertinoIcons.bag_fill, color: dBlueBackground, size: 26.0),
          //             Icon(CupertinoIcons.search, color: dBlack, size: 26.0),
          //             Icon(CupertinoIcons.bell, color: dBlack, size: 26.0),
          //             Icon(CupertinoIcons.person, color: dBlack, size: 26.0),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ]),
      ),
    );
  }
}

// #968f8e

// Image.network(
//                         'https://images.unsplash.com/photo-1570980375900-3128d4f11fac?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGJsYWNrJTIwbWVjaGFuaWN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
//                         height: 230.0,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                       ),
