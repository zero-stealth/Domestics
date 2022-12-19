import 'package:domestics/controllers/user_controller.dart';
import 'package:domestics/data/colors.dart';
import 'package:domestics/widgets/TopControl.dart';
import 'package:domestics/widgets/settings/MyDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var userController = Get.put(UserController());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
              name: "Notifications",
              icon: CupertinoIcons.chevron_back,
              backgroundColor: dBackgroundWhite,
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
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Container(
                      //   padding: EdgeInsets.only(
                      //     left: 10.0,
                      //   ),
                      //   child: Text(
                      //     'Today',
                      //     textAlign: TextAlign.center,
                      //     style: TextStyle(
                      //       fontFamily: 'SFNSR',
                      //       color: Color(0xff262626),
                      //       fontSize: 12.0,
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 5.0),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xfffafafa),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var i in userController.user[0]
                                ['notifications'])
                              Obx(
                                () => NotifyItem(
                                  title: "${i['title']}",
                                  message: "${i['message']}",
                                  length: userController
                                      .user[0]['notifications'].length,
                                  itemIndex: i,
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),
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

class NotifyItem extends StatelessWidget {
  final String title;
  final String message;
  final length;
  final itemIndex;

  NotifyItem({
    required this.title,
    required this.message,
    required this.length,
    required this.itemIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                CupertinoIcons.chat_bubble_2,
                color: dBlueBackground,
                size: 20.0,
              ),
              const SizedBox(width: 20.0),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'AR',
                        color: dBlueBackground,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      message,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontFamily: 'SFNSR',
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
        length == itemIndex ? Container() : const SizedBox(height: 6.0),
        length == itemIndex ? Container() : MyDivider(),
      ],
    );
  }
}
