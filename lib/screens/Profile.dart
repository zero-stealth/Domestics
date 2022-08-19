import 'package:domestics/data/colors.dart';
import 'package:domestics/widgets/Dashboard/Star.dart';
import 'package:domestics/widgets/TopControl.dart';
import 'package:domestics/widgets/settings/MyDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String username;
  final String url;
  final String tag;
  final String bio;
  final String minutesAway;

  Profile({
    required this.username,
    required this.url,
    required this.tag,
    required this.bio,
    required this.minutesAway,
  });

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
                  padding: const EdgeInsets.all(20.0),
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
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  widget.url,
                                ),
                              ),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.pop(context);
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.all(10.0),
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(50.0),
                          //       color: const Color(0xff8e8e90).withOpacity(0.1),
                          //     ),
                          //     child: Center(
                          //       child: Icon(
                          //         CupertinoIcons.clear,
                          //         color: Color(0xff262626),
                          //       ),
                          //     ),
                          //   ),
                          // ),
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
                          fontFamily: 'SFD-Bold',
                          color: Color(0xff262626),
                          fontSize: 12.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        widget.username,
                        style: TextStyle(
                          fontFamily: 'SFD-Bold',
                          color: Color(0xff262626),
                          fontSize: 24.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        widget.bio,
                        style: TextStyle(
                          fontFamily: 'SFT-Regular',
                          color: Color(0xff262626),
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              top: 6.0,
                              bottom: 6.0,
                              left: 20.0,
                              right: 20.0,
                            ),
                            decoration: BoxDecoration(
                                color: const Color(0xff8e8e90).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(50.0)),
                            child: Center(
                              child: Text(
                                widget.tag,
                                style: TextStyle(
                                  fontFamily: 'SFT-Regular',
                                  color: Color(0xff262626),
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                          // const SizedBox(width: 10.0),
                          // Container(
                          //   padding: const EdgeInsets.only(
                          //     top: 6.0,
                          //     bottom: 6.0,
                          //     left: 20.0,
                          //     right: 20.0,
                          //   ),
                          //   decoration: BoxDecoration(
                          //       color: const Color(0xff8e8e90).withOpacity(0.1),
                          //       borderRadius: BorderRadius.circular(50.0)),
                          //   child: Center(
                          //     child: Text(
                          //       'Someone to talk to',
                          //       style: TextStyle(
                          //         fontFamily: 'SFT-Regular',
                          //         color: Color(0xff262626),
                          //         fontSize: 14.0,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
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
                                color: Color.fromARGB(255, 154, 154, 161)
                                    .withOpacity(0.1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.bookmark,
                                      color: dBlack,
                                      size: 18.0,
                                    ),
                                    const SizedBox(width: 15.0),
                                    const Text(
                                      'Save to my list',
                                      style: TextStyle(
                                        fontFamily: 'SFT-Regular',
                                        color: Color(0xff262626),
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
                                  fontFamily: 'SFT-Regular',
                                  color: dBlueBackground,
                                  fontSize: 14.0,
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
                      const SizedBox(height: 10.0),
                      Text(
                        'Reviews',
                        style: TextStyle(
                          fontFamily: 'SFD-Bold',
                          color: Color(0xff262626),
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        decoration: BoxDecoration(
                          color: dBackgroundWhite,
                          border: Border.all(
                            color: dGreyFaded,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Star(),
                                      const Star(),
                                      const Star(),
                                      const Star(),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'Mullah',
                                    style: TextStyle(
                                      fontFamily: 'SFD-Bold',
                                      color: Color(0xff262626),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(height: 6.0),
                                  Text(
                                    'Very good services',
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontFamily: 'SFT-Regular',
                                      color: Color(0xff262626),
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            MyDivider(),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Star(),
                                      const Star(),
                                      const Star(),
                                      const Star(),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'Pauline ',
                                    style: TextStyle(
                                      fontFamily: 'SFD-Bold',
                                      color: Color(0xff262626),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(height: 6.0),
                                  Text(
                                    'I love what you do and appreciate your attention to detail',
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontFamily: 'SFT-Regular',
                                      color: Color(0xff262626),
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            MyDivider(),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Star(),
                                      const Star(),
                                      const Star(),
                                      const Star(),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'Pauline ',
                                    style: TextStyle(
                                      fontFamily: 'SFD-Bold',
                                      color: Color(0xff262626),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(height: 6.0),
                                  Text(
                                    'I love what you do and appreciate your attention to detail',
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontFamily: 'SFT-Regular',
                                      color: Color(0xff262626),
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
      bottomNavigationBar: Container(
        width: double.infinity,
        child: CupertinoButton(
          borderRadius: BorderRadius.circular(0.0),
          padding: const EdgeInsets.only(
            top: 15.0,
            bottom: 15.0,
            left: 0.0,
            right: 0.0,
          ),
          color: dBlueBackground,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                CupertinoIcons.phone_fill,
                color: Colors.white,
                size: 20.0,
              ),
              SizedBox(width: 15.0),
              Text(
                'Call me',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: 'SFD-Bold',
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
    );
  }
}

