import 'package:custom_switch/custom_switch.dart';
import 'package:dealmart/base/BaseStatefullWidget.dart';
import 'package:dealmart/ui/GeneralModels/CountriesModel.dart';
import 'package:dealmart/ui/GeneralModels/GeneralAPi.dart';
import 'package:dealmart/utils/bottomSheet.dart';
import 'package:dealmart/utils/global_vars.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:dealmart/utils/static_ui.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/colors_file.dart' as colorsValues;
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:share/share.dart';

class SettingsScreen extends BaseStatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseState<SettingsScreen> {
  bool notification = false;
  final  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   String SeletedCountyCode="+";
  String SeletedCurrency="Currency";
  String SeletedLanguage="Language";

  CountriesModel countriesModel;
  List <CountriesData> countryList;
  @override
  void initState() {
    super.initState();

 setState(() {
   SeletedCurrency=GlobalVars.Currency;
 });
    getCounries();
    countryList=List();
//
  }
  getCounries(){
    GeneralApi(context).getCountries(_scaffoldKey).then((value) {
      countriesModel = value;
      countriesModel.success.forEach((element) {
        setState(() {
          countryList.add(element);
        });
      });
    });
  }
  showGeneralBottomSheet({bool isLanguage=false,bool isCurrency=false}){
    return Container(
        height: SizeConfig.safeBlockVertical * 40,
        width: SizeConfig.safeBlockHorizontal * 100,
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Column(children: [

          SizedBox(height: 5,),
          Container(width: SizeConfig.safeBlockHorizontal*50,height: 3,decoration: BoxDecoration(color: colorsValues.geyHintText,borderRadius: BorderRadius.circular(25)),),
          SizedBox(height: 15,),

          isLanguage?Column(
            children: [
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 30,
              ),
              ListTile(
                title: Text(translator.translate("English"),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                trailing: translator.currentLanguage == 'en'
                    ? Icon(Icons.check)
                    : Container(
                  height: 1,
                  width: 1,
                ),
                onTap: () {
                  if (translator.currentLanguage == 'en') {
                  } else {
                    translator.setNewLanguage(
                      context,
                      newLanguage: 'en',
                      remember: true,
                      restart: true,
                    );
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 1,
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  if (translator.currentLanguage == 'ar') {
                  } else {
                    translator.setNewLanguage(
                      context,
                      newLanguage: 'ar',
                      remember: true,
                      restart: true,
                    );
                  }
                },
                title: Text(translator.translate("Arabic"),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                trailing: translator.currentLanguage == 'ar'
                    ? Icon(Icons.check)
                    : Container(
                  height: 1,
                  width: 1,
                ),
              ),
            ],
          ):isCurrency?

          Container(
            height: SizeConfig.safeBlockVertical * 35,
            width: SizeConfig.safeBlockHorizontal * 100,
            child: countryList.length==0?StaticUI().progressIndicatorWidget():ListView.builder(itemCount: countryList.length,itemBuilder: (BuildContext context,int index){
              return  ListTile(
                title: Text("${countryList[index].currencyCode}",textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                onTap: () {
                  setState(() {
                    SeletedCurrency="${countryList[index].currencyCode}";
                    GlobalVars.Currency=SeletedCurrency;
                    Navigator.of(context).pop();
                    setUserCurrency(SeletedCurrency, GlobalVars.recharge_fees_amount,   GlobalVars. order_fees_amount, GlobalVars. country_id);
                  });
                },
              );
            }),
          )
              :
Container()


        ],)

    );
  }
  @override
  Widget getAppbar() {
    // TODO: implement getAppbar
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        translator.translate("Setting"),
        style: TextStyle(
          color: Color(0xff212221),
          fontWeight: FontWeight.w600,
          fontSize: 20.0
        ),
      ),
      leading: IconButton(
        onPressed: ()=>Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios,color: Color(0xff212221),size: 20,),
      ),
    );
  }

  @override
  Widget getBody(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height:40,
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Text(
                    translator.translate("Setting"),
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                )),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 5,
            ),
            InkWell(
              onTap: (){},
              child: Container(
                padding: EdgeInsets.only(left: 18, right: 18,bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Image.asset(
                              'images/earth_icon.png',
                                  width: 20,height: 20,
//                              color: Color(0xff434141),
//                              size: 25.0,
                            ),
                          ),
                          SizedBox(width: 15.0,),
                          Container(
                            child: Text(
                              translator.translate("Languages"),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xff434141),
                                fontSize: 14
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){

                        showRoundedModalBottomSheet(
                            autoResize: true,
                            dismissOnTap: false,
                            context: context,
                            radius: 30.0,
                            // This is the default
                            color: Colors.white,
                            // Also default
                            builder: (context) => showGeneralBottomSheet(isLanguage: true));
                       },
                      child: Container(

                        height: 20,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                             translator.currentLanguage=='ar'?"Arabic": "English",
                              style: TextStyle(
                                  color: Color(0xff0098fd),
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.navigate_next,color: colorsValues.orangeColor,size: 25,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            StaticUI().dividerContainer2(context),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
            InkWell(
              onTap: (){},
              child: Container(
                padding: EdgeInsets.only(left: 18, right: 18,bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Image.asset(
                              'images/coins_icon.png',width: 20,height: 20,

//                              color: Color(0xff434141),
//                              size: 25.0,
                            ),
                          ),
                          SizedBox(width: 15.0,),
                          Container(
                            child: Text(
                              SeletedCurrency,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff434141),
                                  fontSize: 14
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        showRoundedModalBottomSheet(
                            autoResize: true,
                            dismissOnTap: false,
                            context: context,
                            radius: 30.0,
                            // This is the default
                            color: Colors.white,
                            // Also default
                            builder: (context) => showGeneralBottomSheet(isCurrency: true));
                      },
                      child: Container(

                        height: 20,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              SeletedCurrency,
                              style: TextStyle(
                                  color: Color(0xff0098fd),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.navigate_next,color: colorsValues.orangeColor,size: 25,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            StaticUI().dividerContainer2(context),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 4,
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Text(
                    translator.translate("General"),
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                )),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 4,
            ),
            InkWell(
              onTap: (){},
              child: Container(
                padding: EdgeInsets.only(left: 18, right: 18,bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Icon(
                              Icons.notifications_none,
                              color: Color(0xff434141).withOpacity(.8),
                              size: 25.0,
                            ),
                          ),
                          SizedBox(width: 15.0,),
                          Container(
                            child: Text(
                              translator.translate("Notifications"),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff434141),
                                  fontSize: 17
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 30,
                      child: CustomSwitch(
                        activeColor: colorsValues.greenColor,
                        value: notification,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 1,
            ),
            StaticUI().dividerContainer2(context),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 3,
            ),
            InkWell(
              onTap: (){},
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20,bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Image.asset(
                              'images/coins_icon.png',
width: 30,height: 30,
//                              color: Color(0xff434141),
//                              size: 25.0,
                            ),
                          ),
                          SizedBox(width: 15.0,),
                          Container(
                            child: Text(
                              translator.translate("App version"),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff434141),
                                  fontSize: 17
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(

                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "V 0.0.1",
                            style: TextStyle(
                                color: Color(0xff0098fd),
                                fontSize: 13,
                                fontWeight: FontWeight.w400
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            SizedBox(
              height: SizeConfig.safeBlockVertical * 1,
            ),
Container(
    alignment: Alignment.centerLeft,padding: EdgeInsets.only(left: 40,right: 40),
    child: Text(translator.translate("Share app"),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14),)),
            SizedBox(
              height: 30,
            ),

            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   Container(
                      decoration: BoxDecoration(
                          color: Color(0xffefefef),
                          borderRadius: BorderRadius.all(Radius.circular(20.0))
                      ),
                      padding: EdgeInsets.only(top: 4.0,bottom: 4.0,left: 15.0,right: 15.0),
                      child: Text(
                        "adel.aly@gmail.com",
                        style: TextStyle(
                            color: Color(0xff9d9d9d),
                            fontWeight: FontWeight.w300,
                            fontSize: 12
                        ),
                      ),
                    ),
                   InkWell(
                     onTap: (){
                       Share.share(translator.translate("Share Text"));
                     },
                     child: Container(
                          width: 70,
                          height: 38,
                          decoration: BoxDecoration(
                              gradient: new LinearGradient(
                                colors: [
                                  Color(0xff009ffd),
                                  Color(0xff002cff)
                                ],
                                stops: [0.0, 2.0],
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text(
                              translator.translate("Invite"),
                              style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: colorsValues.whiteColor),
                            ),
                          ),
                        ),
                   ),
                  ],
                )),

          ],
        ),
      ),
    );
  }
}
