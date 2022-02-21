import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Domestics',
                      style: TextStyle(
                        fontFamily: 'SFD-Bold',
                        color: Color(0xff262626),
                        fontSize: 20.0,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          CupertinoIcons.bell,
                          color: Color(0xff262626),
                          size: 25.0,
                        ),
                        const SizedBox(width: 30.0),
                        const Icon(
                          CupertinoIcons.settings_solid,
                          color: Color(0xff262626),
                          size: 25.0,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   physics: BouncingScrollPhysics(),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Container(
                //         padding: EdgeInsets.only(
                //           left: 20.0,
                //           right: 20.0,
                //           top: 8.0,
                //           bottom: 8.0,
                //         ),
                //         decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.circular(50.0)),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Text(
                //               'Painter',
                //               style: TextStyle(
                //                 color: Color(0xffda4b2e),
                //                 fontFamily: 'SFT-Regular',
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Column(
                  children: [
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(20.0),
                    //   child: Image.network(
                    //     'https://images.unsplash.com/photo-1570980375900-3128d4f11fac?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGJsYWNrJTIwbWVjaGFuaWN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                    //     height: 230.0,
                    //     width: double.infinity,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),

                    DashboardItem(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardItem extends StatelessWidget {
  const DashboardItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              'https://images.unsplash.com/photo-1570980375900-3128d4f11fac?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGJsYWNrJTIwbWVjaGFuaWN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'),
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
                  color: const Color(0xfffafafa),
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
                      'Painter',
                      style: TextStyle(
                        color: Color(0xff262626),
                        fontSize: 14.0,
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
                  color: const Color(0xfffafafa),
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
                        const Text(
                          'Levin Adams',
                          style: TextStyle(
                            color: Color(0xff262626),
                            fontSize: 16.0,
                            fontFamily: 'SFD-Bold',
                          ),
                        ),
                        Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Icon(
                              CupertinoIcons.star_fill,
                              color: Colors.orange,
                              size: 12.0,
                            ),
                            const SizedBox(width: 4.0),
                            Icon(
                              CupertinoIcons.star_fill,
                              color: Colors.orange,
                              size: 12.0,
                            ),
                            const SizedBox(width: 4.0),
                            Icon(
                              CupertinoIcons.star_fill,
                              color: Colors.orange,
                              size: 12.0,
                            ),
                            const SizedBox(width: 4.0),
                            Icon(
                              CupertinoIcons.star_fill,
                              color: Colors.orange,
                              size: 12.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      '3 min away',
                      style: TextStyle(
                        color: Color(0xff968f8e),
                        fontSize: 14.0,
                        fontFamily: 'SFT-Regular',
                      ),
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

// #968f8e

// Image.network(
//                         'https://images.unsplash.com/photo-1570980375900-3128d4f11fac?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGJsYWNrJTIwbWVjaGFuaWN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
//                         height: 230.0,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                       ),
