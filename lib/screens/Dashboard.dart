import 'dart:ui';

import 'package:domestics/widgets/DashboardItem.dart';
import 'package:domestics/widgets/PopularCard.dart';
import 'package:domestics/widgets/Star.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List posts = [
    {
      'tag': 'Tutor',
      'fname': 'Levin Adams',
      'minutesAway': '2 min away',
      'stars': 4,
      'url':
          'https://images.unsplash.com/photo-1529390079861-591de354faf5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8YmxhY2slMjB0ZWFjaGVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    },
    {
      'tag': 'Painter',
      'fname': 'Lily Colt',
      'stars': 2,
      'minutesAway': '1 min away',
      'url':
          'https://images.unsplash.com/photo-1510832842230-87253f48d74f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGFpbnRpbmd8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
    },
    {
      'tag': 'Baby sitter',
      'fname': 'Sarah Payne',
      'stars': 1,
      'minutesAway': '1 min away',
      'url':
          'https://images.unsplash.com/photo-1534806391029-791d2695c38b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmxhY2slMjBiYWJ5fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    },
    {
      'tag': 'Mechanic',
      'fname': 'Brad Philips',
      'stars': 4,
      'minutesAway': '1 min away',
      'url':
          'https://images.unsplash.com/photo-1583954964358-1bd7215b6f7a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8YmxhY2slMjBlbGVjdHJpY2lhbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    },
    {
      'tag': 'Electrician',
      'fname': 'Karl Gibson',
      'stars': 3,
      'minutesAway': '1 min away',
      'url':
          'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8YmxhY2slMjBlbGVjdHJpY2lhbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    },
    {
      'tag': 'IT support',
      'fname': 'Colleen',
      'stars': 4,
      'minutesAway': '1 min away',
      'url':
          'https://images.unsplash.com/photo-1617042375876-a13e36732a04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8YmxhY2slMjBwcm9ncmFtbWVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            elevation: 0.0,
            centerTitle: false,
            automaticallyImplyLeading: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: const Icon(
                  CupertinoIcons.bell,
                  color: Color(0xff262626),
                  size: 25.0,
                ),
              ),
              const SizedBox(width: 28.0),
              Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                  right: 20.0,
                ),
                child: const Icon(
                  CupertinoIcons.settings_solid,
                  color: Color(0xff262626),
                  size: 25.0,
                ),
              )
            ],
            title: Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 5.0,
              ),
              child: const Text(
                'Domestics',
                style: TextStyle(
                  fontFamily: 'SFD-Bold',
                  color: Color(0xff262626),
                  fontSize: 20.0,
                ),
              ),
            ),
            backgroundColor: Color(0xfffafafa),
            // expandedHeight: 100.0,
            floating: true,
            pinned: true,
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
                      top: 15.0,
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
                            fontFamily: 'SFD-Bold',
                            color: Color(0xff262626),
                            fontSize: 16.0,
                          ),
                        ),
                        Icon(
                          CupertinoIcons.arrow_right,
                          size: 20.0,
                          color: Color(0xff262626),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 26.0),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var i in posts)
                          PopularCard(
                            tag: i['tag'],
                            url: i['url'],
                            fname: i['fname'],
                            minutesAway: i['minutesAway'],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ],
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
