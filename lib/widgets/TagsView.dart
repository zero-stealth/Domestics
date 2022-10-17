import 'dart:developer';

import 'package:domestics/Functions/http_service.dart';
import 'package:domestics/data/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TagsView extends StatefulWidget {
  var tags;
  final bool? showMark;
  final String? token;
  final List? toDelete;

  TagsView({
    required this.tags,
    this.showMark,
    this.token,
    this.toDelete,
  });

  @override
  State<TagsView> createState() => _TagsViewState();
}

class _TagsViewState extends State<TagsView> {
  // _removeTag(){

  // }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      direction: Axis.horizontal,
      children: [
        for (var i = 0; i < widget.tags.length; i++)
          InkWell(
            onTap: () async {
                setState(() {
                  widget.toDelete?.add({ "id": widget.tags[i]['tag_id'] });
                  widget.tags.removeAt(i);
                });
                // await populateData(widget.token);
                // log("Failed");
              
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 6.0,
                    bottom: 6.0,
                    left: 20.0,
                    right: 5.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff8e8e90).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.tags[i]['tag'],
                          style: TextStyle(
                            fontFamily: 'SFNSR',
                            color: Color(0xff262626),
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(width: 15.0),
                        widget.showMark == true
                            ? Icon(
                                CupertinoIcons.xmark_circle_fill,
                                size: 20.0,
                                color: dBlack,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}
