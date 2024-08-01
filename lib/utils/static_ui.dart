 import 'package:dealmart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
 import 'package:localize_and_translate/localize_and_translate.dart';
  import 'package:dealmart/utils/colors_file.dart' as colorsValues;
import 'package:dealmart/utils/image_file.dart' as imagesfile;
import 'package:dealmart/utils/image_file.dart' as image_file;
 import 'package:dealmart/resources/AppColors.dart';
class StaticUI {
  Decoration containerDecoration({Color colorValue,double borderRidusValue,}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRidusValue),
      color: colorValue,
      border: Border.all(color: colorsValues.primaryAppColor)

    );
  }

  dividerContainer(BuildContext context){
    return     Container(
      height: .5,
      color: Colors.grey,
      width: SizeConfig.safeBlockHorizontal*70,
    );
  }
  dividerContainer2(BuildContext context){
    return     Container(
      height: .5,
      color: Color(0xffe7e7e7),
      width: SizeConfig.safeBlockHorizontal*90,
    );
  }
Widget signInWithSocialMedia(BuildContext context){
    return Column(
      children: [
      SizedBox(height: 19,),
      Container(
        width: MediaQuery.of(context).size.width,
        height: 62,
        decoration: BoxDecoration(
          color: Color.fromRGBO(61,90,150, 1),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Center(child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              FontAwesome.facebook,
              size: 25,
              color: Colors.white,
            ),
            SizedBox(width: 19,),
            Text(translator.translate('Sign up with Facebook'),style: TextStyle(color: WHITE,fontSize: 17,fontWeight: FontWeight.bold),),
          ],
        )),
      ),

      SizedBox(height: 19,),
      Container(
        width: MediaQuery.of(context).size.width,
        height: 62,
        decoration: BoxDecoration(
          color: Color.fromRGBO(42,163,239, 1),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Center(child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              FontAwesome.twitter,
              size: 25,
              color: Colors.white,
            ),
            SizedBox(width: 19,),
            Text(translator.translate('Sign up with twitter'),style: TextStyle(color: WHITE,fontSize: 17,fontWeight: FontWeight.bold),),
          ],
        )),
      ),

      SizedBox(height: 19,),
      Container(
        width: MediaQuery.of(context).size.width,
        height: 62,
        decoration: BoxDecoration(
          color: Color.fromRGBO(61,90,150, 1),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Center(child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              FontAwesome.google,
              size: 25,
              color: Colors.white,
            ),
            SizedBox(width: 19,),
            Text(translator.translate('Sign up with Google'),style: TextStyle(color: WHITE,fontSize: 17,fontWeight: FontWeight.bold),),
          ],
        )),
      )
    ],);
}

 Widget appBarWidget(String appBArName){
    return AppBar(
      elevation: 0,
      backgroundColor: colorsValues.whiteColor,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: colorsValues.blackColor, //change your color here
      ),

      title: Center(
        child: Text(
          appBArName,
          style: TextStyle(color: colorsValues.blackColor,fontSize: 18),
        ),
      ),
    );
 }



  void showSnackbar(String message, GlobalKey<ScaffoldState> scaffoldKey,{Color color = Colors.red}) {

    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: color,
    ));
  }

  progressIndicatorWidget() {
    return Center(
        child: Container(
          child: CircularProgressIndicator(
            backgroundColor: colorsValues.primaryAppColor,
            valueColor: AlwaysStoppedAnimation(colorsValues.whiteColor),
          ),
        ));
  }
  NoDataFoundWidget() {
    return Container(
      height: SizeConfig.safeBlockVertical*100,
        width: SizeConfig.safeBlockHorizontal*100,
        padding: EdgeInsets.only(top: 20),

        child: Column(
          children: [
            Image.asset('images/noData.png'),
            SizedBox(height: 85,),
            Text(translator.translate(translator.translate('noDataFound')),style: TextStyle(color: Color(0xffadadad),fontSize: 22), ),
          ],
        )
    );
  }

  closeApp(BuildContext context){
    showDialog(

        context: context,
        builder: (context)=>Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(17),),
          child: ClipRRect(borderRadius: BorderRadius.circular(17),
            child: AlertDialog(
              shape: RoundedRectangleBorder(borderRadius:
                BorderRadius.all(Radius.circular(17))),
              elevation: 5.0,
              backgroundColor: Colors.white,
              titlePadding: EdgeInsets.all(16.0),
              title: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(17)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.0,),
                    Container(
                        child: Text(translator.translate("Are you sure you want to exit?"),style: TextStyle(fontSize: 15,color: Color(0xff707070),fontWeight: FontWeight.w700),)
                    ),
                    SizedBox(height: 25.0,),
                    Image.asset("images/logOutImage.jpeg",height:100 ,width: 100,),
                    Container(padding: EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 75,
                              height: 30,
                              decoration: BoxDecoration(
                                gradient: new LinearGradient(
                                  colors: [
                                    colorsValues.azure,
                                    colorsValues.vibrantBlue,
                                  ],
                                  begin: FractionalOffset.topCenter,
                                  end: FractionalOffset.bottomCenter,

                                ),
                                borderRadius: BorderRadius.all(Radius.circular(8.5)),
                              ),
                              child: Center(
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                        color: WHITE, fontSize: 12, fontWeight: FontWeight.w800),
                                  )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                            },
                            child: Container(
                              width: 75,
                              height: 30,
                              decoration: BoxDecoration(
                                gradient: new LinearGradient(
                                  colors: [
                                    Color(0xfffa9f42),
                                    Color(0xffee752a),
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight,

                                ),
                                borderRadius: BorderRadius.all(Radius.circular(8.5)),
                              ),
                              child: Center(
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                        color: WHITE, fontSize: 12, fontWeight: FontWeight.w800),
                                  )),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

}


