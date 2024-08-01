import 'package:dealmart/utils/global_vars.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dealmart/utils/colors_file.dart' as colorsValues;
import 'package:localize_and_translate/localize_and_translate.dart';

class NotificationCenter {
  static bool canShow = true;
  BuildContext context ;
  NotificationCenter(BuildContext context){
    this.context = context;
  }
showNotificationDailog(message){
  if (canShow == false) {return;}
  canShow = false;
    String youGet=message['notification']['body'].toString().split(',')[0];
    String fromAccountNum=message['notification']['body'].toString().split(',')[1];
    String accountNum= "" ;
    String accountNum2= "" ;
    if (message['notification']['body'].toString().split(',').length > 2 ) {
     accountNum=message['notification']['body'].toString().split(',')[2];
     accountNum2=message['notification']['body'].toString().split(',')[3];}
  Dialog errorDialog = Dialog(

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
    child: Container(
      height:  300.0,
      width: 300.0,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[
          Padding(
            padding:  EdgeInsets.all(15.0),
            child: Text(message['notification']['title'], style: TextStyle(color: colorsValues.blackColor,fontSize: 16,fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding:  EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("${youGet}", style: TextStyle(color: colorsValues.oceanBlue),),
                SizedBox(height: 8,),
                accountNum == "" ? Text("${fromAccountNum} ", style: TextStyle(color: colorsValues.blackColor,fontSize: 16,fontWeight: FontWeight.bold),)
                    : Text("${fromAccountNum} ${ GlobalVars.Currency}", style: TextStyle(color: colorsValues.blackColor,fontSize: 16,fontWeight: FontWeight.bold),),
                SizedBox(height: 8,),

                Text("${accountNum}", style: TextStyle(color: colorsValues.oceanBlue),),
                SizedBox(height: 8,),

                Text("${accountNum2}", style: TextStyle(color: colorsValues.blackColor,fontSize: 16,fontWeight: FontWeight.bold),),
               ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),  GestureDetector(onTap: (){
            canShow = true;
            Navigator.of(context).pop();
            //navigateAndKeepStack(context, MainScreen());

          },
              child: Container(padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: colorsValues.primaryAppColor,
              ),child: Text(translator.translate("Ok"), style: TextStyle(color:colorsValues.whiteColor, fontSize: 18.0),))),

        ],
      ),
    ),
  );
  showDialog(context: context, barrierDismissible: false,builder: (BuildContext newcontext) {
   return  WillPopScope(child: errorDialog,onWillPop: (){
      canShow = true ;
      Navigator.of(newcontext).pop();
    });
  });

}
  initConfigure(){
    print("  initConfigure");


    FirebaseMessaging().configure(
      // onMessage: (Map<String, dynamic> message) async {
      //   print('onMessag : $message');
      //
      //   showNotificationDailog(message);
      //
      // },
      onResume: (Map<String, dynamic> message) async {
      print('onMessageonResume : $message');
        print('2 : $message');
      //  showNotificationDailog(message);


      },
      onLaunch: (Map<String, dynamic> message) async {
         print('onMessageonLaunch : $message');
        print('3 : $message');
    //    showNotificationDailog(message);
      },
    );
  }
  Future<String>  getNotificationDeviceToken() async {
    FirebaseMessaging().getToken().then((firebaseToken) {

      print("ddssdxfirebase_taken /n $firebaseToken}");
      return "$firebaseToken";
      // setFCMToken(context, userFCMToken: firebaseToken);
    });
  }
}
// class NotificationDialog {
//   Map<String, dynamic> message
//   String youGet=message['notification']['body'].toString().split(',')[0];
//   String fromAccountNum=message['notification']['body'].toString().split(',')[1];
//   String accountNum=message['notification']['body'].toString().split(',')[2];
//   String accountNum2=message['notification']['body'].toString().split(',')[3];
//  //create an object of SingleObject
//   static Dialog instance = new Dialog(
//
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
//     child: Container(
//       height: 300.0,
//       width: 300.0,
//
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//
//         children: <Widget>[
//           Padding(
//             padding:  EdgeInsets.all(15.0),
//             child: Text(message['notification']['title'], style: TextStyle(color: colorsValues.blackColor,fontWeight: FontWeight.bold),),
//           ),
//           Padding(
//             padding:  EdgeInsets.all(15.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text("${youGet}", style: TextStyle(color: colorsValues.greyColorXd),),
//                 SizedBox(height: 8,),
//                 Text("${fromAccountNum}", style: TextStyle(color: colorsValues.blackColor,fontWeight: FontWeight.bold),),
//                 SizedBox(height: 8,),
//
//                 Text("${accountNum}", style: TextStyle(color: colorsValues.greyColorXd),),
//                 SizedBox(height: 8,),
//
//                 Text("${accountNum2}", style: TextStyle(color: colorsValues.blackColor,fontWeight: FontWeight.bold),),
//               ],
//             ),
//           ),
//           Padding(padding: EdgeInsets.only(top: 20.0)),  GestureDetector(onTap: (){
//             Navigator.of(context).pop();
//             navigateAndKeepStack(context, MainScreen());
//
//           },
//               child: Container(padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),decoration:  BoxDecoration(
//                 borderRadius: BorderRadius.circular(25),
//                 color: colorsValues.primaryAppColor,
//               ),child: Text(stringsfile.ok, style: TextStyle(color:colorsValues.whiteColor, fontSize: 18.0),))),
//
//         ],
//       ),
//     ),
//   );
//
//  //make the constructor private so that this class cannot be
//  //instantiated
//   SingleObject(){}
//
//  //Get the only object available
//   static SingleObject getInstance(){
//    return instance;
//  }
//
//
//}