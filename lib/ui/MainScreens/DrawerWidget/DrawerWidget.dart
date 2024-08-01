import 'package:custom_switch/custom_switch.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/ContactUs/ContactUs.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/MyAddress/MyAddress.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/SettingsScreen/SettingsScreen.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/WalletScreen/WalletScreen.dart';
import 'package:dealmart/ui/MainScreens/MainScreen.dart';
import 'package:dealmart/ui/Notifications/NotificationScreen.dart';
import 'package:dealmart/ui/WelcomeScreen/WelcomeScreen.dart';
import 'package:dealmart/ui/sign_in/SignIn.dart';
import 'package:dealmart/utils/global_vars.dart';
import 'package:dealmart/utils/image_file.dart';
import 'package:dealmart/utils/navigator.dart';
import 'package:dealmart/utils/size_config.dart';
import 'package:dealmart/utils/static_ui.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/image_file.dart' as image_file;
import 'package:dealmart/utils/colors_file.dart' as colorsValues;
import 'package:dealmart/utils/shared_utils.dart' as shared;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


import 'OrderScreen/OrderScreen.dart';
class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool notification = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.safeBlockVertical * 10,
              ),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Icon(Icons.clear,size: 30,))),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 3,
              ),
              ListTile(onTap: (){
                Navigator.of(context).pop();
                navigateAndClearStack(context, MainScreen(position: 4,));
              },
                leading:
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: image_file.placeHolderImageProfile,
                      image: GlobalVars.userData == null? "" :GlobalVars.userData.profilePicture.toString() == 'null'? "" : "https://dealmart.herokuapp.com/" + GlobalVars.userData.profilePicture,
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 70,
                  height: 70,
                ),
                title: Text(
                  GlobalVars.userData == null?"" : "${GlobalVars.userData.fullName}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 3,
              ),
              InkWell(

                onTap: (){
                  Navigator.of(context).pop();
                  navigateAndKeepStack(context, WalletScreen());

                },
                child: Container(
                  height: SizeConfig.safeBlockVertical * 9,
                  width: SizeConfig.safeBlockHorizontal * 70,
                  decoration: BoxDecoration(
                      gradient: new LinearGradient(
                        colors: [
                          Color.fromRGBO(0, 159, 254, 1.0),
                          Color.fromRGBO(0, 44, 255, 1.0)
                        ],
                        stops: [0.0, 1.0],
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          translator.translate("Wallet Balance"),
                          style: TextStyle(color: colorsValues.whiteColor,fontSize: 12),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${GlobalVars.userData.wallet.currentBalance} ${ GlobalVars.Currency}",
                          style: TextStyle(
                              color: colorsValues.whiteColor, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              SizedBox(
                height: 50,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                margin: EdgeInsets.only(left: 15.0,right: 15.0),
                child: InkWell(
                  onTap: (){
                    navigateAndClearStack(context, MainScreen(position: 1,));
                  },
                  child: Row(
                    children: [
                      Image.asset('images/favorate_icon.png',color: Color(0xff1a1007).withOpacity(.8),width: 25,height: 25,),
                      SizedBox(width: 25,),
                      Text(translator.translate("Favourites"),style: TextStyle(color: Color(0xff1a1007).withOpacity(.8),fontSize: 14,fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              StaticUI(). dividerContainer(context),
              SizedBox(
                height: 20,
              ),

              Container(
                margin: EdgeInsets.only(left: 15.0,right: 15.0),
                width: MediaQuery.of(context).size.width / 1.1,
                child: InkWell(
                  onTap: (){
                    navigateAndKeepStack(context, OrderScreen());
                  },
                  child: Row(
                    children: [
                      Image.asset(ORDERS,color: Color(0xff1a1007).withOpacity(.8),width: 22,height: 22,),
                      SizedBox(width: 25,),
                      Text(translator.translate("My Orders"),style: TextStyle(color: Color(0xff1a1007).withOpacity(.8),fontSize: 14,fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              StaticUI(). dividerContainer(context),




              SizedBox(
                height: 20,
              ),

              Container(
                margin: EdgeInsets.only(left: 15.0,right: 15.0),
                width: MediaQuery.of(context).size.width / 1.1,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyAddress(fromCheckOut: false,)));
                  },
                  child: Row(
                    children: [
                      Image.asset(LOCATION,color: Color(0xff1a1007).withOpacity(.8),width: 22,height: 22,),
                      SizedBox(width: 25,),
                      Text(translator.translate("Address"),style: TextStyle(color: Color(0xff1a1007).withOpacity(.8),fontSize: 14,fontWeight: FontWeight.w400)),
                    ],
                  ),
                )

              ),
              SizedBox(
                height: 20,
              ),
              StaticUI(). dividerContainer(context),




              SizedBox(
                height: 20,
              ),

              Container(
                margin: EdgeInsets.only(left: 15.0,right: 15.0),
                width: MediaQuery.of(context).size.width / 1.1,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUs()));

                  },
                  child:Row(
                    children: [
                      Image.asset(CONTACT_US,color: Color(0xff1a1007).withOpacity(.8),width: 22,height: 22,),
                      SizedBox(width: 25,),
                      Text(translator.translate("Contact Us "),style: TextStyle(color: Color(0xff1a1007).withOpacity(.8),fontSize: 14,fontWeight: FontWeight.w400)),
                    ],
                  ) ,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              StaticUI(). dividerContainer(context),




              SizedBox(
                height: 20,
              ),

              Container(
                margin: EdgeInsets.only(left: 15.0,right: 15.0),
                width: MediaQuery.of(context).size.width / 1.1,
                child: InkWell(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));

                  },
                  child: Row(
                    children: [
                      Image.asset('images/settings_icon.png',color: Color(0xff1a1007).withOpacity(.8),width: 22,height: 22,),
                      SizedBox(width: 25,),
                      Text(translator.translate("Setting"),style: TextStyle(color: Color(0xff1a1007).withOpacity(.8),fontSize: 14,fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
             StaticUI(). dividerContainer(context),



             SizedBox(
               height: 20,
             ),
             InkWell(
               onTap: (){

                 Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));

               },
               child: Container(
                 margin: EdgeInsets.only(left: 15.0,right: 15.0),
                 width: MediaQuery.of(context).size.width / 1.1,
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
                               size: 28.0,
                             ),
                           ),
                           SizedBox(width: 12.0,),
                           Container(
                             child: Text(
                               translator.translate("Notifications"),
                                 style: TextStyle(color: Color(0xff1a1007).withOpacity(.8),fontSize: 14,fontWeight: FontWeight.w400)
                             ),
                           ),
                         ],
                       ),
                     ),
                     Container(
                       height: 30,
                       child: Row(
                         children: [
                           CustomSwitch(
                             activeColor: colorsValues.greenColor,
                             value: notification,
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
             ),
             SizedBox(
               height: 20,
             ),
              StaticUI(). dividerContainer(context),



              SizedBox(
                height: 20,
              ),

              Container(
                margin: EdgeInsets.only(left: 15.0,right: 15.0),
                width: MediaQuery.of(context).size.width / 1.1,
                child: InkWell(
                  onTap: (){
                    FacebookLogin().logOut();
                    GoogleSignIn().disconnect();
                     FirebaseAuth.instance.signOut();
                    shared.removeKeyFromShared(context,key: 'userToken');
                    shared.setRememberMe(false);
                    navigateAndClearStack(context, WelcomeScreen());
                    // navigateAndClearStack(context, SignIn());
                  },
                  child: Row(
                      children: [
                        Image.asset(LOGOUT,color: Color(0xff1a1007).withOpacity(.8),width: 22,height: 22,),
                        SizedBox(width: 25,),
                        Text(translator.translate("Logout"),style: TextStyle(color: Color(0xff1a1007).withOpacity(.8),fontSize: 14,fontWeight: FontWeight.w400)),
                      ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
//             StaticUI(). dividerContainer(context),
            ],
          ),
        ),
      ),
    );
  }
}
