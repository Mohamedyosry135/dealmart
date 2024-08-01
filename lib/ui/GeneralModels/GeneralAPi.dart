import 'dart:convert';
import 'dart:io';

import 'package:dealmart/api/remote/API_PATHS.dart';
import 'package:dealmart/ui/GeneralModels/CountriesModel.dart';
import 'package:dealmart/ui/Notifications/NotificationModel.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:dealmart/utils/static_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class GeneralApi{
  BuildContext context;


  GeneralApi(this.context);
  String getDiffrenceTime(String requestTimeCreated){
    String TimeCreated='';

    if(DateTime.now().difference(DateTime.parse('${requestTimeCreated}')).inMinutes<60){
      TimeCreated= '${DateTime.now().difference(DateTime.parse('${requestTimeCreated}')).inMinutes}'+' '+"Minute" +' '+ "ago";

    }
    else if(DateTime.now().difference(DateTime.parse('${requestTimeCreated}')).inHours<24){
      TimeCreated= '${DateTime.now().difference(DateTime.parse('${requestTimeCreated}')).inHours}'+' '+"Hour" +' '+ "ago";

    }
    else if(DateTime.now().difference(DateTime.parse('${requestTimeCreated}')).inDays<30){
      TimeCreated= '${DateTime.now().difference(DateTime.parse('${requestTimeCreated}')).inDays}'+' '+"Day" +' '+ "ago";

    }

    return TimeCreated;
  }

  Future<dynamic> setTocken(String firebaseTocken)async {
    try {

      print("cancelOrdercancelOrder ${"https://dealmart.herokuapp.com${FIREBASETOCKEN}"}");
      final response = await http.post(
          "https://dealmart.herokuapp.com${FIREBASETOCKEN}",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${userToken}"
          },body: {
        "firebase_token": firebaseTocken

      }
      );

      print("bodybody ${response.statusCode}");
       if(response.statusCode == 200){
        return true;
      }else{
       }

    }
    catch(e){
      // StaticUI().showSnackbar("Error", _scaffoldKey);
      print("RepoError ${e}");
      //throw e;
    }
  }

  Future<dynamic> getCountries(GlobalKey<ScaffoldState> _scaffoldKey)async {
    try {
      final response = await http.get(
          "https://dealmart.herokuapp.com${COUNTRIES}",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${userToken}"
          }
      );
      print("BODY ${json.decode(response.body)}");
      if(response.statusCode == 200){
        return CountriesModel.fromJson(json.decode(response.body));
      }else{
        StaticUI().showSnackbar("Error", _scaffoldKey);
      }

    }
    catch(e){
      StaticUI().showSnackbar("Error", _scaffoldKey);
      print("RepoError ${e}");
      throw e;
    }
  }



  Future<dynamic> getNotifications(GlobalKey<ScaffoldState> _scaffoldKey)async {
    try {
      final response = await http.get(
          "https://dealmart.herokuapp.com${NOTIFICATIONS}",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${userToken}"
          }
      );
      print("BODY ${json.decode(response.body)}");
      if(response.statusCode == 200){
        return NotificationModel.fromJson(json.decode(response.body));
      }else{
        StaticUI().showSnackbar("Error", _scaffoldKey);
      }

    }
    catch(e){
      StaticUI().showSnackbar("Error", _scaffoldKey);
      print("RepoError ${e}");
      throw e;
    }
  }

  bool checkPlatform(){
    if(Platform.isAndroid){
      return true;
    }
    else {
      return false;
    }

  }
}