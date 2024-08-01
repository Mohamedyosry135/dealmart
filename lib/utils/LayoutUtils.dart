import 'dart:ui';
import 'package:dealmart/resources/Strings.dart';
import 'package:flutter/material.dart';


class LayoutUtils{

  static TextDirection getLayoutDirection(){
    return Strings.english?TextDirection.ltr:TextDirection.rtl;
  }
  static Widget wrapWithtinLayoutDirection(Widget widget){
    return new Directionality(
        textDirection: getLayoutDirection(),
        child:widget);
  }


  static EdgeInsetsGeometry marPad(double top, double bottom, double start, double end){
    return new EdgeInsets.fromLTRB(Strings.english?start:end, top, Strings.english?end:start, bottom);
  }


}