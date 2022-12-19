import 'dart:developer';

import 'package:domestics/Functions/SettingsFuncs.dart';
import 'package:domestics/data/UserData.dart';
import 'package:domestics/database/database_helper.dart';
import 'package:domestics/screens/Edit.dart';
import 'package:domestics/screens/Login.dart';
import 'package:domestics/widgets/TopControl.dart';
import 'package:domestics/widgets/settings/MyDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Functions/http_service.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _dbHelper = DatabaseHelper.instance;
  var data = [];
  var refferals = [];

  getInfo() async {
    var info = await _dbHelper.queryAllRows("userInfo");
    var reff = await _dbHelper.queryAllRows("refferals");
    setState(() {
      data = info;
      refferals = reff;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
    // getWorkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffefefef),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            TopControl(
              name: "Settings",
              icon: CupertinoIcons.chevron_back,
              backgroundColor: Colors.transparent,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xfffafafa),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // EditProfileModal(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Edit()),
                                );
                              },
                              child: SettingsItem(
                                icon: CupertinoIcons.person,
                                color: Color(0xff262626),
                                name: 'Edit Profile',
                                trailing: true,
                              ),
                            ),
                            MyDivider(),
                            InkWell(
                              onTap: () {
                                securityModal(context, data[0]['token']);
                              },
                              child: SettingsItem(
                                icon: CupertinoIcons.lock,
                                color: Color(0xff262626),
                                name: 'Security',
                                trailing: true,
                              ),
                            ),
                            MyDivider(),
                            InkWell(
                              onTap: () {
                                referredModal(context, refferals);
                              },
                              child: SettingsItem(
                                icon: CupertinoIcons.link,
                                color: Color(0xff262626),
                                name: 'Referred to me',
                                trailing: true,
                              ),
                            ),
                            MyDivider(),
                            // InkWell(
                            //   onTap: () {
                            //     statsModal(context);
                            //   },
                            //   child: SettingsItem(
                            //     icon: CupertinoIcons.graph_square,
                            //     color: Color(0xff262626),
                            //     name: 'Stats',
                            //     trailing: true,
                            //   ),
                            // ),
                            // MyDivider(),
                            InkWell(
                              onTap: () {
                                feedbackModal(context, data[0]['token']);
                              },
                              child: SettingsItem(
                                icon: CupertinoIcons.chat_bubble,
                                color: Color(0xff262626),
                                name: 'Feedback',
                                trailing: true,
                              ),
                            ),
                            MyDivider(),
                            InkWell(
                              onTap: () async {
                                var status = await logoutAll();
                                await dbHelper.deleteTable("userInfo");
                                status == true
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()),
                                      )
                                    : log("Failed");
                              },
                              child: SettingsItem(
                                icon: CupertinoIcons.bag_badge_minus,
                                color: Colors.redAccent,
                                name: 'Logout',
                                trailing: false,
                              ),
                            ),
                          ],
                        ),
                      ),
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

class SettingsItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final bool trailing;

  SettingsItem({
    required this.name,
    required this.icon,
    required this.color,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 20.0,
                color: color,
              ),
              const SizedBox(width: 20.0),
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'SFNSR',
                  color: color,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          trailing == true
              ? Icon(
                  CupertinoIcons.chevron_right,
                  size: 20.0,
                  color: Color(0xff262626),
                )
              : Container(),
        ],
      ),
    );
  }
}
