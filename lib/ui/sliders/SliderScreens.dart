import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/resources/Strings.dart';
import 'package:dealmart/ui/WelcomeScreen/WelcomeScreen.dart';
import 'package:dealmart/utils/image_file.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:dealmart/utils/colors_file.dart' as colorsValues;
import 'package:localize_and_translate/localize_and_translate.dart';

import 'custom_sliders/CustomIntroSlider.dart';

class SliderScreens extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SliderScreensState();
  }
}

class SliderScreensState extends State<SliderScreens> {
  List<Slide> slides = new List();
  bool isFirst = true;

  @override
  void initState() {
    super.initState();
  }

  void onDonePress() {
    navigateAndKeepStack(context, WelcomeScreen());

    // Do what you want

//    Navigator.pushNamedAndRemoveUntil(context, "/sign_in", (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    double imageHeight = MediaQuery.of(context).size.height / 2.3;
    if (isFirst) {
      slides.add(
        new Slide(

          widgetDescription: Column(
            children: [
              Image.asset(APP_LOGO),
              Image.asset('images/slide_1.png'),
              SizedBox(height: 15,),
              Text(
                translator.translate("Start exploring"),
                textAlign: TextAlign.center,style: TextStyle(fontSize: 28,fontWeight: FontWeight.w800,color: Color(0xff060606)),
              ),
              SizedBox(height: 15,),

              Text(
                translator.translate("Explore The app & Start wining by order as many products as you can Shop more and Buy more"),
                textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: colorsValues.geySlider,height: 1.5)
              ),
            ],
          ),

          backgroundColor: WHITE,


         ),
      );
      slides.add(
        new Slide(

          widgetDescription: Column(
            children: [
              Image.asset(APP_LOGO),
              Image.asset('images/slide_1.png'),
              SizedBox(height: 15,),
              Text(
                translator.translate("Start exploring"),
                textAlign: TextAlign.center,style: TextStyle(fontSize: 28,fontWeight: FontWeight.w800,color: Color(0xff060606)),
              ),
              SizedBox(height: 15,),

              Text(
                translator.translate("Explore The app & Start wining by order as many products as you can Shop more and Buy more"),
                  textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: colorsValues.geySlider,height: 1.5)
              ),
            ],
          ),

          backgroundColor: WHITE,


        ),
      );
      slides.add(
        new Slide(

          widgetDescription: Column(
            children: [
              Image.asset(APP_LOGO),
              Image.asset('images/slide_1.png'),
              SizedBox(height: 15,),
              Text(
                translator.translate("Start exploring"),
                textAlign: TextAlign.center,style: TextStyle(fontSize: 28,fontWeight: FontWeight.w800,color: Color(0xff060606)),
              ),
              SizedBox(height: 15,),

              Text(
                translator.translate("Explore The app & Start wining by order as many products as you can Shop more and Buy more"),
                  textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: colorsValues.geySlider,height: 1.5)
              ),
            ],
          ),

          backgroundColor: WHITE,


        ),
      );

      setState(() {
        isFirst = false;
      });
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: IntroSlider(
        slides: this.slides,
        sizeDot: 15,
        colorActiveDot: PRIMARY_COLOR,
        colorDot: Color(0xffcddede),
        styleNameDoneBtn:
            TextStyle(color: WHITE, fontSize: 16, fontWeight: FontWeight.w600),
        styleNamePrevBtn: TextStyle(
            color: PRIMARY_COLOR, fontSize: 16, fontWeight: FontWeight.w600),
        styleNameSkipBtn: TextStyle(
          color: Color(0xff393533),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        nameDoneBtn: Strings.txt_get_started(),
        nameNextBtn: Strings.next(),
        nameSkipBtn: Strings.skip(),
        onDonePress: this.onDonePress,
        onSkipPress: this.onDonePress,
      ),
    );
  }
}
