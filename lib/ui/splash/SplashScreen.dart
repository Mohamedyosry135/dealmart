import 'dart:async';
import 'dart:developer';

import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/ui/MainScreens/MainScreen.dart';
import 'package:dealmart/ui/sliders/SliderScreens.dart';
import 'package:dealmart/utils/global_vars.dart';
import 'package:dealmart/utils/image_file.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    log("userToken  "+userToken);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _getSplashScreen()
    );
  }

  Widget _getSplashScreen() {
    Timer(Duration(seconds: 3), () {
      if(remember){
        goToHome();
        setState(() {
          getCartLength().then((value){
            GlobalVars.cartLength = value.toString();
            print("cartLength ${value.toString()}");
          });

        });
      }else
        goToSlides();
    });
    return
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: WHITE
        ),
        child:  Center(
          child: Image.asset(splashGifs,width: MediaQuery.of(context).size.width,fit: BoxFit.fill,height: MediaQuery.of(context).size.height/3,),
        ),
      );

  }

  void goToSlides() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SliderScreens()));
  }


  void goToHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(position: 2,)));
  }
}
