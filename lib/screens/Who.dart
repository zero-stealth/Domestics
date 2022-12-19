import 'package:domestics/data/colors.dart';
import 'package:domestics/screens/Selections.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Who extends StatefulWidget {
  const Who({Key? key}) : super(key: key);

  @override
  State<Who> createState() => _WhoState();
}

class _WhoState extends State<Who> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  var workerStatus = false;

  statusHandler() {
    switch (workerStatus) {
      case false:
        setState(() {
          workerStatus = true;
        });
        break;

      case true:
        setState(() {
          workerStatus = false;
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dBackgroundWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.all(20.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.person, color: dGreyFaded, size: 100.0),
                SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    statusHandler();
                  },
                  child: WhoTab(
                    icon: CupertinoIcons.person_badge_plus,
                    desc: "I am a worker looking for clients.",
                    selected: workerStatus,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    statusHandler();
                  },
                  child: WhoTab(
                    icon: CupertinoIcons.person,
                    desc: "I am looking for workers to help me with stuff.",
                    selected: !workerStatus,
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    bottom: 20.0,
                    left: 0.0,
                    right: 0.0,
                  ),
                  child: CupertinoButton(
                    color: dBlueBackground,
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: dWhitePure,
                        fontSize: 16.0,
                        fontFamily: 'SFD-Bold',
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Selections()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WhoTab extends StatefulWidget {
  final String desc;
  final IconData icon;
  final bool selected;

  WhoTab({
    required this.desc,
    required this.selected,
    required this.icon,
  });

  @override
  State<WhoTab> createState() => _WhoTabState();
}

class _WhoTabState extends State<WhoTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: widget.selected == false ? dGreyFadedPlus : dBlueBackground,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            widget.icon,
            color: widget.selected == false ? dBlack : dWhitePure,
            size: 24.0,
          ),
          SizedBox(width: 30.0),
          Flexible(
            child: Text(
              widget.desc,
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'SFT-Regular',
                color: widget.selected == false ? dBlack : dWhitePure,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
