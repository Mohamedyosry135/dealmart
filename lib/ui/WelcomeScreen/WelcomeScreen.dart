import 'package:dealmart/resources/AppColors.dart';
import 'package:dealmart/ui/GeneralModels/CountriesModel.dart';
import 'package:dealmart/ui/GeneralModels/GeneralAPi.dart';
import 'package:dealmart/ui/signUp/RegistScreen.dart';
import 'package:dealmart/ui/sign_in/SignIn.dart';
import 'package:dealmart/utils/bottomSheet.dart';
import 'package:dealmart/utils/global_vars.dart';
import 'package:dealmart/utils/image_file.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:dealmart/utils/static_ui.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/image_file.dart' as image_file;
import 'package:dealmart/utils/colors_file.dart' as colorsValues;
import 'package:localize_and_translate/localize_and_translate.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String SeletedCurrency=translator.translate("Currency");
  String SeletedCounty=translator.translate("Country");
  String SeletedCountyCode="+";

  String SeletedLanguage=translator.translate("Language");

  CountriesModel countriesModel;
  List <CountriesData> countryList;
  @override
  void initState() {
    super.initState();
    setState(() {
       SeletedLanguage=translator.currentLanguage.toString()=="ar"?"Arabic":"English";
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
  showGeneralBottomSheet({bool isCountry=false,bool isLanguage=false,bool isCurrency=false}){
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
                title: Text("${countryList[index].currencyCode}",textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                onTap: () {
                  setState(() {
                    SeletedCurrency="${countryList[index].currencyCode}";
                    GlobalVars.Currency=SeletedCurrency;

                    Navigator.of(context).pop();
                  });
                },
              );
            }),
          )
              :


          Container(
            height: SizeConfig.safeBlockVertical * 35,
            width: SizeConfig.safeBlockHorizontal * 100,
            child: countryList.length==0?StaticUI().progressIndicatorWidget():ListView.builder(itemCount: countryList.length,itemBuilder: (BuildContext context,int index){
              return  ListTile(
                title: Text("${translator.currentLanguage=='ar'?countryList[index].countryNameAr:countryList[index].countryNameEn}",textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),

                onTap: () {
                  setState(() {
                    SeletedCountyCode="";
                    SeletedCounty=translator.currentLanguage=='ar'?countryList[index].countryNameAr:countryList[index].countryNameEn;
                    SeletedCountyCode="+"+countryList[index].callingCode;
                    GlobalVars.Country=SeletedCountyCode;
                    GlobalVars.recharge_fees_amount = countryList[index].fee.rechargeFeesAmount;
                    GlobalVars.order_fees_amount = countryList[index].fee.orderFeesAmount;
                    GlobalVars.country_id = countryList[index].fee.countryId.toString();
                    Navigator.of(context).pop();

                  });
                },
              );
            }),
          )
        ],)

    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(width: SizeConfig.safeBlockHorizontal*100,height: SizeConfig.safeBlockVertical*20,child: Column(children: [
        InkWell(
          onTap: (){

            print("SeletedCountyCode ${SeletedCountyCode}");
              if(SeletedCurrency=="Currency"||SeletedCounty=="Country"){

                StaticUI().showSnackbar("Please Enter Currency and Country", _scaffoldKey);
              }
              else {
                setUserCurrency(SeletedCurrency, GlobalVars.recharge_fees_amount,   GlobalVars. order_fees_amount, GlobalVars. country_id).then((value) {
                  navigateAndKeepStack(context, SignIn());

                });

              }



          },
          child: Container(
            margin: EdgeInsets.only(bottom: 15),
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
              child:Text(translator.translate('Sign in'),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: colorsValues.whiteColor),),
            ),
          ),
        ),

        InkWell(
          onTap: (){


              if(SeletedCurrency=="Currency"||SeletedCounty=="Country"){
                StaticUI().showSnackbar("Please Enter Currency and Country", _scaffoldKey);
              }
              else {
                setUserCurrency(SeletedCurrency, GlobalVars.recharge_fees_amount,   GlobalVars. order_fees_amount, GlobalVars. country_id).then((value) {
                  navigateAndKeepStack(context, RegistScreen());

                });

              }

          },
          child: Container(
            height: 55,
            width: MediaQuery.of(context).size.width/1.1,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.orange,width: 1),

                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            child: Center(
              child:Text(translator.translate('Sign Up'),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: colorsValues.orange),),
            ),
          ),
        ),

      ],),),
      body: Container(
        color: colorsValues.whiteColor,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.safeBlockVertical*20,
              ),
              Text(translator.translate("Welcome"),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 24),),

              Container(
                width: MediaQuery.of(context).size.width,
                height: SizeConfig.safeBlockVertical*10,
                decoration: BoxDecoration(color: WHITE),
                child: Center(
                  child: Image.asset(
                    'images/dealMartLogo.png',
                    width: 250,
                    fit: BoxFit.contain,
                    height: 800,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
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
                      builder: (context) => showGeneralBottomSheet(isCountry: true));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: colorsValues.borderGray,width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  width: SizeConfig.safeBlockHorizontal * 90,
                  height: 60,
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Image.asset(
                              'images/flag.png',
                              width: 23,height: 23,
//                              color: Color(0xff434141),
//                              size: 25.0,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(SeletedCounty,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18,))
                        ],
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: colorsValues.orangeColor,
                      )
                    ],
                  ),
                ),
              ),



              SizedBox(
                height: 10,
              ),
              InkWell(onTap: (){
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
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: colorsValues.borderGray,width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  width: SizeConfig.safeBlockHorizontal * 90,
                  height: 60,
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Image.asset(
                              'images/earth_icon.png',
                              width: 23,height: 23,
//                              color: Color(0xff434141),
//                              size: 25.0,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(SeletedLanguage,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18,),)
                        ],
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: colorsValues.orangeColor,

                      )
                    ],
                  ),
                ),
              )


              ,
              SizedBox(
                height: 10,
              ),
              InkWell(onTap: (){
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
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: colorsValues.borderGray,width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  width: SizeConfig.safeBlockHorizontal * 90,
                  height: 60,
                  padding: EdgeInsets.only(left: 23,right: 23),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Image.asset(
                              'images/coins_icon.png',width: 20,height: 20,

//                              color: Color(0xff434141),
//                              size: 25.0,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(SeletedCurrency,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18,))
                        ],
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: colorsValues.orangeColor,
                      )
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
