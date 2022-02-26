import 'package:domestics/widgets/settings/MyDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
                child: InkWell(
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
                  'Notifications',
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
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 10.0,
                        ),
                        child: Text(
                          'Today',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'SFT-Regular',
                            color: Color(0xff262626),
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xfffafafa),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NotifyItem(
                                title: 'Domestics Team',
                                message:
                                    'We have updated our privacy visit our website to learn more.'),
                            const SizedBox(height: 6.0),
                            MyDivider(),
                            NotifyItem(
                                title: 'Linked',
                                message: 'Chico linked you to Evans.'),
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

class NotifyItem extends StatelessWidget {
  final String title;
  final String message;

  NotifyItem({
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            CupertinoIcons.chat_bubble,
            color: Color(0xff262626),
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
                    fontFamily: 'SFD-Bold',
                    color: Color(0xff262626),
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  message,
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
    );
  }
}
