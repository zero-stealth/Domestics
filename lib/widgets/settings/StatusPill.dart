import 'package:domestics/data/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusPill extends StatefulWidget {
  final bool isWorker;
  final String tag;
  final String desc;

  StatusPill({
    required this.isWorker,
    required this.tag,
    required this.desc,
  });

  @override
  State<StatusPill> createState() => _StatusPillState();
}

class _StatusPillState extends State<StatusPill> {
  calcBackgroundColor(){
    switch (widget.tag) {
      case "Worker":
        if(widget.isWorker == true){
          return dBlueBackground;
        } else {
          return dGreyFaded;
        }

      case "Client":
        if(widget.isWorker == false){
          return dBlueBackground;
        } else {
          return dGreyFaded;
        }
      default:
    }
  }

  calcBorderColor(){
    switch (widget.tag) {
      case "Client":
        if(widget.isWorker == true){
          return dGreyFadedPlus;
        }else {
          return dWhitePureFaded;
        }

      case "Worker":
        if(widget.isWorker == true){
          return dWhitePureFaded;
        }else {
          return dGreyFadedPlus;
        }
    }
  }

  calcTextColor(){
    switch (widget.tag) {
      case "Client":
        if(widget.isWorker == true){
          return dBlack;
        }else {
          return dWhitePure;
        }

      case "Worker":
        if(widget.isWorker == true){
          return dWhitePure;
        }else {
          return dBlack;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: calcBackgroundColor()
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            CupertinoIcons.person,
            color: calcTextColor(),
            size: 20.0,
          ),
          const SizedBox(width: 15.0),
          Container(
            width: 2.0,
            height: 20.0,
            decoration: BoxDecoration(
              color: calcBorderColor(),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          const SizedBox(width: 15.0),
          Text(
            widget.tag,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: "SFNSR",
              fontSize: 16.0,
              color: calcTextColor(),
            ),
          ),
        ],
      ),
    );
  }
}