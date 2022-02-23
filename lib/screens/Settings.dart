import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  _feedbackModal(context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
              const SizedBox(height: 15.0),
              const Text(
                'Feedback',
                style: TextStyle(
                  fontFamily: 'SFD-Bold',
                  color: Color(0xff262626),
                  fontSize: 22.0,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Send us your thoughts, ideas or say hi. Life is too short.',
                style: TextStyle(
                  fontFamily: 'SFT-Regular',
                  color: Color(0xff8e8e90),
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 20.0),
              CupertinoTextField(
                padding: const EdgeInsets.all(20.0),
                placeholder: 'Type something',
                minLines: 4,
                maxLines: 4,
                decoration: BoxDecoration(
                    color: const Color(0xff8e8e90).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              const SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                child: CupertinoButton(
                  color: Colors.blueAccent,
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: 'SFT-Regular',
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffefefef),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              elevation: 0.0,
              centerTitle: false,
              automaticallyImplyLeading: false,
              actions: [
                // Padding(
                //   padding: const EdgeInsets.only(
                //     top: 10.0,
                //   ),
                //   child: const Icon(
                //     CupertinoIcons.bell,
                //     color: Color(0xff262626),
                //     size: 23.0,
                //   ),
                // ),
                // const SizedBox(width: 28.0),
                // Padding(
                //   padding: EdgeInsets.only(
                //     top: 10.0,
                //     right: 20.0,
                //   ),
                //   child: GestureDetector(
                //     onTap: (){
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(builder: (context) => Settings()),
                //         );
                //     },
                //     child: const Icon(
                //       CupertinoIcons.settings_solid,
                //       color: Color(0xff262626),
                //       size: 23.0,
                //     ),
                //   ),
                // )
              ],
              leading: Padding(
                padding: EdgeInsets.only(
                  left: 5.0,
                  top: 10.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    CupertinoIcons.arrow_left,
                    size: 20.0,
                    color: Color(0xff262626),
                  ),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: const Text(
                  'Settings',
                  style: TextStyle(
                    fontFamily: 'SFD-Bold',
                    color: Color(0xff262626),
                    fontSize: 20.0,
                  ),
                ),
              ),
              backgroundColor: const Color(0xffefefef),
              // expandedHeight: 100.0,
              floating: true,
              pinned: true,
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
                            SettingsItem(
                                icon: CupertinoIcons.person,
                                color: Color(0xff262626),
                                name: 'Edit Profile'),
                            MyDivider(),
                            SettingsItem(
                                icon: CupertinoIcons.lock,
                                color: Color(0xff262626),
                                name: 'Security'),
                            MyDivider(),
                            SettingsItem(
                                icon: CupertinoIcons.link,
                                color: Color(0xff262626),
                                name: 'Referred to me'),
                            MyDivider(),
                            SettingsItem(
                                icon: CupertinoIcons.graph_square,
                                color: Color(0xff262626),
                                name: 'Stats'),
                            MyDivider(),
                            InkWell(
                              onTap: () {
                                _feedbackModal(context);
                              },
                              child: SettingsItem(
                                  icon: CupertinoIcons.chat_bubble,
                                  color: Color(0xff262626),
                                  name: 'Feedback'),
                            ),
                            MyDivider(),
                            SettingsItem(
                                icon: CupertinoIcons.bag_badge_minus,
                                color: Colors.redAccent,
                                name: 'Logout'),
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

class MyDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Color(0xff8e8e90).withOpacity(0.1),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;

  SettingsItem({
    required this.name,
    required this.icon,
    required this.color,
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
                  fontFamily: 'SFT-Regular',
                  color: color,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          Icon(
            CupertinoIcons.chevron_right,
            size: 20.0,
            color: Color(0xff262626),
          ),
        ],
      ),
    );
  }
}
