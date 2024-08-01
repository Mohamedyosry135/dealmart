import 'package:flutter/material.dart';

import 'AppColors.dart';

class Styles {
  static final appBarStyle = TextStyle(color: WHITE, fontSize: 19);
  static final fontStyle = TextStyle(
      color: const Color(0xff040404),
      fontWeight: FontWeight.bold,
      fontFamily: "OpenSans",
      fontStyle: FontStyle.normal,
      fontSize: 20.3);
  static final boldSubTitleStyle =
  TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  static final blueBoldSubTitleStyle = TextStyle(
      fontSize: 14, color: PRIMARY_COLOR, fontWeight: FontWeight.bold);
  static final numberStyle = TextStyle(
      color: PRIMARY_COLOR, fontSize: 15, fontWeight: FontWeight.bold);
  static final buttonText =
  TextStyle(fontSize: 16, color: WHITE, fontWeight: FontWeight.bold);
  static final thirdSubTitle =
  TextStyle(fontWeight: FontWeight.w500, fontSize: 14);
  static final TextStyle RAISED_BTN_TEXT_STYLE = new TextStyle(
    color: WHITE,
    fontSize: 15,
    fontFamily: "Regular",
  );

  static final doctorSpecialityAtSearch =
  TextStyle(color: BLACK, fontSize: 10, fontWeight: FontWeight.w300);
}