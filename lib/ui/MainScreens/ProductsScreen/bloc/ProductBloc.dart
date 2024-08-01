import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dealmart/api/remote/API_PATHS.dart';
import 'package:dealmart/api/remote/EndPoint.dart';
import 'package:dealmart/ui/MainScreens/ProductsScreen/model/ProductModel.dart';
import 'package:dealmart/ui/MainScreens/ProductsScreen/model/SliderModel.dart';
import 'package:dealmart/ui/MainScreens/ProductsScreen/model/TodayWinnerModel.dart';
import 'package:dealmart/ui/MainScreens/ProductsScreen/model/TopWinnerModel.dart';
import 'package:dealmart/ui/MainScreens/ProductsScreen/product_details/model/ProductDetailsModel.dart';
import 'package:dealmart/ui/MainScreens/ProfileScreen/model/EditProfileResponse.dart';
import 'package:dealmart/ui/MyFavouritesScreens/model/FavouriteModel.dart';
import 'package:dealmart/ui/signUp/model/RegisterResponseModel.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dealmart/utils/static_ui.dart';
class ProductBloc{
  var dio = Dio();
  Future<dynamic> getProduct(GlobalKey<ScaffoldState> _scaffoldKey)async {

      final response = await http.get(
          "https://dealmart.herokuapp.com${PRODUCTAPI}",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${userToken}"
          }
      );
      log(response.body);
      if(response.statusCode == 200){

        print("response.body ${response.body}");
        return ProductModel.fromJson(json.decode(response.body));
      }else{
        StaticUI().showSnackbar("Error", _scaffoldKey);
      }

    }
  Future<dynamic> getSilderData()async {

    final response = await http.get(
        "https://dealmart.herokuapp.com${SLIDER}",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${userToken}"
        }
    );
    log(response.body);
    if(response.statusCode == 200){

      print("response.body ${response.body}");
      return SliderModel.fromJson(json.decode(response.body));
    }else{
     // StaticUI().showSnackbar("Error", _scaffoldKey);
    }

  }

}