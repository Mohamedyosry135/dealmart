import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dealmart/api/remote/API_PATHS.dart';
import 'package:dealmart/api/remote/EndPoint.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/WalletScreen/transactionModel.dart';
import 'package:dealmart/ui/MainScreens/ProductsScreen/product_details/model/ProductDetailsModel.dart';
import 'package:dealmart/ui/MainScreens/ProfileScreen/model/EditProfileResponse.dart';
import 'package:dealmart/ui/MainScreens/model/userModel.dart';
import 'package:dealmart/ui/MyFavouritesScreens/model/FavouriteModel.dart';
import 'package:dealmart/ui/signUp/model/RegisterResponseModel.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dealmart/utils/static_ui.dart';
class UserInfo{
  var dio = Dio();
  Future<dynamic> getUserInfo(GlobalKey<ScaffoldState> _scaffoldKey)async {

      try{
        final response = await http.get(
            "https://dealmart.herokuapp.com${USERINFOAPI}",
            headers: {
              HttpHeaders.authorizationHeader: "Bearer ${userToken}"
            }
        );
        print("BODYInfo ${json.decode(response.body)}");
        if(response.statusCode == 200){
          return UserModel.fromJson(json.decode(response.body));
        }else{
          StaticUI().showSnackbar("Error", _scaffoldKey);
        }
      }catch(e){
        print("ResponseError ${e}");
        return null;
      }

    }

  Future<dynamic> getTransaction(GlobalKey<ScaffoldState> _scaffoldKey)async {
   log("Bearer ${userToken}");
    try{
      final response = await http.get(
          "http://dealmart.herokuapp.com/api/transaction?page=1",
          headers: {
            HttpHeaders.authorizationHeader : "Bearer ${userToken}"
          }
      );
      print("getTransaction ${json.decode(response.body)}");
      if(response.statusCode == 200){
       return TransactionsModel.fromJson(json.decode(response.body));
      }else{
        print("getTransaction res = "+json.decode(response.body));
        StaticUI().showSnackbar("Error", _scaffoldKey);
      }
    }catch(e){
      print("getTransaction res = Error");
      return null;
    }

  }



}