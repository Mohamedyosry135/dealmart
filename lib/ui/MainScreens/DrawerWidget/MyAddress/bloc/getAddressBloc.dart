import 'dart:convert';
import 'dart:io';

import 'package:dealmart/api/remote/API_PATHS.dart';
import 'package:dealmart/api/remote/EndPoint.dart';
import 'package:dealmart/ui/MainScreens/DrawerWidget/MyAddress/model/Address_model.dart';
import 'package:dealmart/ui/MainScreens/ProfileScreen/model/EditProfileResponse.dart';
import 'package:dealmart/ui/MyFavouritesScreens/model/FavouriteModel.dart';
import 'package:dealmart/ui/signUp/model/RegisterResponseModel.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dealmart/utils/static_ui.dart';
class GetAddress{

  Future<dynamic> getAddress(GlobalKey<ScaffoldState> _scaffoldKey)async {
    try {
      final response = await http.get(
          "https://dealmart.herokuapp.com${ADDRESSAPI}",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${userToken}"
          }
      );
      print("BODY ${json.decode(response.body)}");
      if(response.statusCode == 200){
        return AddressModel.fromJson(json.decode(response.body));
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
}