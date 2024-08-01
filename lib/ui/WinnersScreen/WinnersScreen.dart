import 'package:dealmart/ui/MainScreens/ProductsScreen/model/TodayWinnerModel.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:dealmart/utils/static_ui.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/image_file.dart' as image_file;
import 'package:localize_and_translate/localize_and_translate.dart';

class WinnersScreen extends StatefulWidget {
  List<TodayWinner> todayWinner = List();

  WinnersScreen(this.todayWinner);

  @override
  _WinnersScreenState createState() => _WinnersScreenState();
}

class _WinnersScreenState extends State<WinnersScreen> {



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: StaticUI().appBarWidget(translator.translate("Winners")),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          width: SizeConfig.safeBlockHorizontal * 100,
          height: SizeConfig.safeBlockVertical * 90,
          child: ListView.builder(
              itemCount: widget.todayWinner.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: SizeConfig.safeBlockHorizontal * 100,
                  height: SizeConfig.safeBlockVertical * 40,
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: SizeConfig.safeBlockHorizontal * 100,
                        height: SizeConfig.safeBlockVertical * 8,
                        margin: EdgeInsets.only(left: 5,right: 5),
                        decoration: BoxDecoration(
                          gradient: new LinearGradient(
                            colors: [
                              Color(0xffd199dc),
                              Color(0xff7870e7),
                            ],
                            stops: [0.0, 2.0],
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                          ),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                        ),
                        child: Text(
                          translator.translate("Congratulations"),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top:   SizeConfig.safeBlockVertical * 7,),
                        child: Card(

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))),

                          child: Container(
                             decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            width: SizeConfig.safeBlockHorizontal * 100,
                            height: SizeConfig.safeBlockVertical * 30
                            ,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  widget. todayWinner[index].user.profilePicture.toString() == 'null'?   Image.asset(image_file.placeHolderImageProfile,   width: SizeConfig.safeBlockHorizontal * 50,
                                    height: 70,):     Image.network(
                                  "https://dealmart.herokuapp.com/" + widget.todayWinner[index].user.profilePicture,
                                    width: SizeConfig.safeBlockHorizontal * 50,
                                    height: 70,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      SizedBox(width: 1,),
                                      Text(translator.translate("Ticket Number")),

                                      Text(
                                        widget.todayWinner[index].giftId.toString(),
                                        style: TextStyle(color: Color(0xfff38734)),
                                      ),
                                      SizedBox(width: 1,),


                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [                                      SizedBox(width: 50,),

                                      Text(translator.translate("Announce Date")),

                                      Text(
                                        widget.todayWinner[index].updatedAt.split("T")[0],
                                        style: TextStyle(color: Color(0xfff38734)),
                                      ),                                      SizedBox(width: 50,),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
