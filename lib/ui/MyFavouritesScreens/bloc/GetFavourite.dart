import 'dart:convert';
import 'dart:io';

import 'package:dealmart/api/model/BaseApiResponse.dart';
import 'package:dealmart/api/remote/API_PATHS.dart';
import 'package:dealmart/api/remote/EndPoint.dart';
import 'package:dealmart/ui/MainScreens/ProfileScreen/model/EditProfileResponse.dart';
import 'package:dealmart/ui/MyFavouritesScreens/model/FavouriteModel.dart';
import 'package:dealmart/ui/signUp/model/RegisterResponseModel.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dealmart/utils/static_ui.dart';
class GetFavouritesBloc{
  var dio = Dio();
  Future<dynamic> getFavourites(GlobalKey<ScaffoldState> _scaffoldKey)async {
    try {
      final response = await http.get(
          "https://dealmart.herokuapp.com${FAVOURITEAPI}",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${userToken}"
          }
      );
      print("BODY ${json.decode(response.body)}");
      if(response.statusCode == 200){
        return FavouriteModel.fromJson(json.decode(response.body));
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

  Future<dynamic> addFavourites(GlobalKey<ScaffoldState> _scaffoldKey,int itemId)async {
    try {
      final response = await http.post(
          "https://dealmart.herokuapp.com${ADDFAVOURITEAPI+itemId.toString()}",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${userToken}"
          }
      );
      print("BODY ${json.decode(response.body)}");
      if(response.statusCode == 200){
        return BaseApiResponse.fromJson(json.decode(response.body));
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

  Future<dynamic> removeFromFavourites(GlobalKey<ScaffoldState> _scaffoldKey,String productId)async {
    try {
      final response = await http.post(
          "https://dealmart.herokuapp.com${REMOVEFROMFAVOURITES}${productId}",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${userToken}"
          }
      );
      print("RemoveBody ${productId}");
      print("RemoveBody ${json.decode(response.body)}");
      if(response.statusCode == 200){
        return true;
      }else{
        StaticUI().showSnackbar("Error", _scaffoldKey);
      }

    }
    catch(e){
      // StaticUI().showSnackbar("Error", _scaffoldKey);
      print("RepoError ${e}");
      //throw e;
    }
  }
  Future<dynamic> removeOrder(GlobalKey<ScaffoldState> _scaffoldKey,String orderID)async {
    try {

      print("cancelOrdercancelOrder ${"https://dealmart.herokuapp.com${cancelOrder}"}");
      final response = await http.post(
          "https://dealmart.herokuapp.com${cancelOrder}",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${userToken}"
          },body: {
        "order_id": orderID

      }
      );
      print("RemoveBody ${orderID}");
      print("RemoveBody ${json.decode(response.body)}");
      if(response.statusCode == 200){
        return true;
      }else{
        StaticUI().showSnackbar("Error", _scaffoldKey);
      }

    }
    catch(e){
      // StaticUI().showSnackbar("Error", _scaffoldKey);
      print("RepoError ${e}");
      //throw e;
    }
  }

}