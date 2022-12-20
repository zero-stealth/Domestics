import 'package:domestics/data/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

const baseUrl = "http://139.144.178.129:3000";

buttonStatus(buttonState, text) {
  switch (buttonState) {
    case "loading":
      return LoadingAnimationWidget.inkDrop(
        color: dWhitePure,
        size: 20.0,
      );

    case "notloading":
      return Text(
        text,
        style: TextStyle(color: dWhitePure, fontSize: 16.0, fontFamily: 'AR'),
      );
  }
}

String capitalize(String s) {
  if (s.isEmpty) {
    return s;
  } else {
    return s[0].toUpperCase() + s.substring(1);
  }
}
