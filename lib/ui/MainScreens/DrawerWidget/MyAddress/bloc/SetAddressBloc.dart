import 'dart:convert';
import 'dart:io';

import 'package:dealmart/api/remote/API_PATHS.dart';
import 'package:dealmart/api/remote/EndPoint.dart';
import 'package:dealmart/base/BaseStatefullWidget.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/MyAddress/model/Address_model.dart';
import 'package:dealmart/ui/MainScreens/MainScreen.dart';
import 'package:dealmart/ui/MainScreens/ProfileScreen/model/EditProfileResponse.dart';
import 'package:dealmart/ui/MyFavouritesScreens/model/FavouriteModel.dart';
import 'package:dealmart/ui/signUp/model/RegisterResponseModel.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dealmart/utils/static_ui.dart';
class SetAddressBloc {
  var dio = Dio();
  Future<bool> setAddress(GlobalKey<ScaffoldState> _scaffoldKey,BuildContext context,String address,String lat,String lng,{String phone="",String first_name="",String last_name=""})async {
    try {
print("addressaddress ${{
  "address": address,
  "lat": lat,
  "lng": lng,

  "phone":phone.isEmpty?"123456789":phone,
  "first_name":first_name.isEmpty?"first_name":first_name,

  "last_name":last_name.isEmpty?"last_name":last_name
}}");
      final response = await http.post(
          "https://dealmart.herokuapp.com${ADDRESSAPI}",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${userToken}"
          },
        body: {
          "address": address,
          "lat": lat,
          "lng": lng,

          "phone":phone.isEmpty?"123456789":phone,
          "first_name":first_name.isEmpty?"first_name":first_name,

          "last_name":last_name.isEmpty?"last_name":last_name
        }
      );
      print("BODY ${json.decode(response.body)}");
      if(response.statusCode == 200){
       return true;
      }else{
         StaticUI().showSnackbar("Error", _scaffoldKey);
         return false;
      }

    }
    catch(e){
      StaticUI().showSnackbar("Error", _scaffoldKey);
      print("RepoError ${e}");
      throw e;
    }
  }

  Future<bool> setAddressDefault(GlobalKey<ScaffoldState> _scaffoldKey,int addressID)async {
    try {
      final response = await http.post(
          "https://dealmart.herokuapp.com${ADDRESSAPIDEFAULT}$addressID",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${userToken}"
          },

      );
      print("BODY ${json.decode(response.body)}");
      if(response.statusCode == 200){
        return true;
      }else{
        StaticUI().showSnackbar("Error", _scaffoldKey);
        return false;
      }

    }
    catch(e){
      StaticUI().showSnackbar("Error", _scaffoldKey);
      print("RepoError ${e}");
      throw e;
    }
  }

}