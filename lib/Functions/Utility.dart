import 'package:domestics/data/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

buttonStatus(buttonState, text) {
  switch (buttonState) {
    case "loading":
      return LoadingAnimationWidget.inkDrop(
        color: dWhitePure,
        size: 20.0,
      );

    default:
      return Text(
        text,
        style: TextStyle(
            color: dWhitePure, fontSize: 16.0, fontFamily: 'SFD-Bold'),
      );
  }
}
