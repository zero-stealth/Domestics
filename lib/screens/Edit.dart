import 'package:domestics/data/colors.dart';
import 'package:domestics/database/database_helper.dart';
import 'package:domestics/widgets/TopControl.dart';
import 'package:domestics/widgets/settings/MyDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _dbHelper = DatabaseHelper.instance;
  var data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
  }

  getInfo() async {
    var info = await _dbHelper.queryAllRows("userInfo");
    setState(() {
      data = info;
    });
  }

  String capitalize(String s) {
    return s[0].toUpperCase() + s.substring(1);
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
              name: "Edit Profile",
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
                              },
                              child: InfoItem(
                                title: "First name",
                                value: data.length == 0
                                    ? "-"
                                    : capitalize(data[0]['fname']),
                              ),
                            ),
                            MyDivider(),
                            InkWell(
                              onTap: () {
                                // EditProfileModal(context);
                              },
                              child: InfoItem(
                                title: "Last name",
                                value: data.length == 0
                                    ? "-"
                                    : capitalize(data[0]['lname']),
                              ),
                            ),
                            MyDivider(),
                            InkWell(
                              onTap: () {
                                // EditProfileModal(context);
                              },
                              child: InfoItem(
                                title: "Email",
                                value: data.length == 0
                                    ? "-"
                                    : capitalize(data[0]['email']),
                              ),
                            ),
                            MyDivider(),
                            InkWell(
                              onTap: () {
                                // EditProfileModal(context);
                              },
                              child: InfoItem(
                                title: "Bio",
                                value: data.length == 0
                                    ? "-"
                                    : capitalize(data[0]['bio']),
                              ),
                            ),
                            MyDivider(),
                            InkWell(
                              onTap: () {
                                // EditProfileModal(context);
                              },
                              child: InfoItem(
                                title: "Phone number",
                                value: data.length == 0
                                    ? "-"
                                    :"+${data[0]['phone']}",
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

class InfoItem extends StatelessWidget {
  final String title;
  final String value;

  InfoItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'SFNSR',
                  color: dBlack,
                  fontSize: 12.0,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'SFNSR',
                  color: dBlack,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          Icon(
            CupertinoIcons.chevron_right,
            color: dBlack,
            size: 20.0,
          ),
        ],
      ),
    );
  }
}

class EditItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final bool trailing;

  EditItem({
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
