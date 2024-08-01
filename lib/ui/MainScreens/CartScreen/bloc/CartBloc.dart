import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:dealmart/api/model/BaseApiResponse.dart';
import 'package:dealmart/api/remote/API_PATHS.dart';
import 'package:dealmart/ui/MainScreens/CartScreen/model/CartResponseModel.dart';
import 'package:dealmart/utils/global_vars.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:dealmart/utils/static_ui.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';




class CartBloc{

  Future<dynamic> addToCart(GlobalKey<ScaffoldState> _scaffoldKey,int itemId,int amount)async {
    try {
      final response = await http.post(
          "https://dealmart.herokuapp.com${ADDTOCART}",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${userToken}"
          },
        body:  {
          'product_id':itemId.toString(),
          'amount':amount.toString(),
          // "country_id":GlobalVars. country_id
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
     // StaticUI().showSnackbar("Error", _scaffoldKey);
      print("RepoError ${e}");
      //throw e;
    }
  }

  Future<dynamic> getCarts(GlobalKey<ScaffoldState> _scaffoldKey)async {
    try {
      final response = await http.get(
          "https://dealmart.herokuapp.com${GETCART}",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${userToken}"
          }
      );
      print("BODY ${json.decode(response.body)}");
      if(response.statusCode == 200){
        return CartResponseModel.fromJson(json.decode(response.body));
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


  Future<dynamic> removeFromCarts(GlobalKey<ScaffoldState> _scaffoldKey,String productId)async {
    try {
      final response = await http.post(
          "https://dealmart.herokuapp.com${REMOVEFROMCART}${productId}",
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
  Future<dynamic> editCartsAmount(GlobalKey<ScaffoldState> _scaffoldKey,String productId,String amount)async {
    try {
      final response = await http.post(
          "https://dealmart.herokuapp.com${EDITCARDAMOUNT}",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${userToken}"
          },
        body: {
          "product_id": productId,
          "amount": amount,
          // "country_id":GlobalVars. country_id
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
  Future<String> buyAllCart(GlobalKey<ScaffoldState> _scaffoldKey)async {
    try {
      final response = await http.post(
          "https://dealmart.herokuapp.com${BUYALLCART}",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${userToken}"
          },
          body: {
            "country_id" : GlobalVars.country_id.toString()
            // "promocode" : promocode

          }
      );
      print("buyBody ${json.decode(response.body)}");
      print("buyBody ${response.statusCode}");
      if(response.statusCode == 200){
          return "200";
      }else{
        return "${json.decode(response.body)['error']}";
      }

    }
    catch(e){
      // StaticUI().showSnackbar("Error", _scaffoldKey);
      print("RepoError ${e}");
      return "There's Error";

      //throw e;
    }
  }
  Future chargeCard(GlobalKey<ScaffoldState> _scaffoldKey,Map data,int type)async {
    // try {
       data["type"]="${type}";
      final response = await http.post(
          "https://dealmart.herokuapp.com${CHARGECARD}",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${userToken}"
          },
          body: data
      );

      print("response ${json.decode(response.body)['otp']}");
      print("statusCode ${(response.statusCode)}");
       if(response.statusCode == 200){
        return json.decode(response.body);
      }else{
         return json.decode(response.body);
      }

  //  }
    // catch(e){
    //   // StaticUI().showSnackbar("Error", _scaffoldKey);
    //   print("RepoError ${e}");
    //   return "There's Error";
    //
    //   //throw e;
    // }
  }

  Future checkPromo(GlobalKey<ScaffoldState> _scaffoldKey,String promoCode)async{
    try {
      final response = await http.post(
        "https://dealmart.herokuapp.com${CHECKPROMO}",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${userToken}"
        },
        body: {
          "promocode" : promoCode
        }
      );

      if(response.statusCode == 200){
        return json.decode(response.body)['success']['price'].toString();
      }else{
        return "error";
      }

    }
    catch(e){
      // StaticUI().showSnackbar("Error", _scaffoldKey);
      print("RepoError ${e}");
      return false;

      //throw e;
    }
  }


  Future checkTarnsaction(GlobalKey<ScaffoldState> _scaffoldKey,String transaction_id)async{
    try {
      final response = await http.get(
          "https://dealmart.herokuapp.com/api/check/transaction/${transaction_id}",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${userToken}"
          },
      );
         print("transactiontransaction ${json.decode(response.body)}");
      if(response.statusCode == 200){
        return  json.decode(response.body)['success'] ;
      }else{
        return 0;
      }

    }
    catch(e){
      // StaticUI().showSnackbar("Error", _scaffoldKey);
      print("RepoError ${e}");
      return 0;

      //throw e;
    }
  }
  Future chargeFawry(GlobalKey<ScaffoldState> _scaffoldKey,String name , double amount,String mobile ,int type)async{
    try {
     Map parameter = {
        "customer_name":name,
    "type":"${type}",
    "amount":amount.toString(),
    "phone":mobile,
    };
     if (type == 1){
       parameter["county_id"] = GlobalVars.country_id;
     }
     print(parameter);
      final response = await http.post(
        "https://dealmart.herokuapp.com/api/charge/fawry",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${userToken}"
        },body:
        parameter

      );
      print(json.decode(response.body));
      if(response.statusCode == 200){
        return  json.decode(response.body) ;
      }else{
        return  json.decode(response.body);
      }

    }
    catch(e){
      // StaticUI().showSnackbar("Error", _scaffoldKey);
      print("RepoError ${e}");
      return 0;

      //throw e;
    }
  }
}