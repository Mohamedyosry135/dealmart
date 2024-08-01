import 'package:dealmart/ui/MainScreens/DrawerWidget/OrderScreen/OrderScreen.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:dealmart/utils/static_ui.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/colors_file.dart' as colors;
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class FailCheckOut extends StatefulWidget {
  @override
  _FailCheckOutState createState() => _FailCheckOutState();
}

class _FailCheckOutState extends State<FailCheckOut> {

  Future<bool> closeApp(){
    StaticUI().closeApp(context);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: closeApp,
      child: Scaffold(floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:       InkWell(
          onTap: (){
Navigator.of(context).pop();        },
          child: Container(
            margin: EdgeInsets.only(bottom: 40),
            height: 55,
            width: MediaQuery.of(context).size.width/1.1,
             decoration: BoxDecoration(
                gradient: new LinearGradient(
                  colors: [
                       Color(0xfffa9f42),
                      Color(0xffee752a),
                  ],
                  stops: [0.0, 2.0],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            child: Center(
              child:Text(translator.translate('Try again'),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: colors.whiteColor),),
            ),
          ),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 95,
                height: 95,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), color: colors.tomato),
                child: Center(
                  child: Icon(
                    Icons.clear,
                    color: colors.whiteColor,size: 45,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                translator.translate("Order Failed"),
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(

                  translator.translate("There's a problem in the requested order"),
                  style: TextStyle(color: colors.grey.withOpacity(.7), fontSize: 13,height: 1.5),
                  textAlign: TextAlign.center,

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
