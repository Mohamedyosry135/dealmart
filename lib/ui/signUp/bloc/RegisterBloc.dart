
import 'dart:convert';

import 'package:dealmart/api/AppConfig.dart';
import 'package:dealmart/api/remote/API_PATHS.dart';
import 'package:dealmart/api/remote/EndPoint.dart';
import 'package:dealmart/ui/signUp/model/RegisterResponseModel.dart';
import 'package:dealmart/ui/sign_in/model/LoginResponse.dart';
import 'package:dealmart/utils/global_vars.dart';
import 'package:dealmart/utils/staticVar.dart';
import 'package:http/http.dart' as http;
class RegisterBloc{
  void callRegister(Function onSuccess, Function onError,String full_name,String phone,String email,String password) {
    EndPoint.shared
        .setMethodType(RequestType.post)
        .setNeedAuth(false)
        .callStreamRequest('post', REGISTERAPI,json.encode({
      'full_name': full_name,
      'phone': phone,
      'email': email,
      'password': password,
    }),(json) => RegisterResponseModel.fromJson(json),
        contentType: APPLICATION_JSON)
        .then((stream) {
      stream.listen((data) => onSuccess(data));
    }).catchError((error) => onError(error));
  }

  Future<int> checkUser(String phone,String email,{isOnlyPhone=false})async{

    print("phonephonephone ${phone}");
    try{
      var response = await http.post(
          "https://dealmart.herokuapp.com" + CHECKUSER,
          body: isOnlyPhone?
          {
            'phone' : phone,
          }:{

              'phone' : phone,
              'email' : email

          }
      );
      print("responseError ${response.body}");
      return response.statusCode;
    }catch(e){
      print("responseError ${e}");
      return 0;
    }
  }

  void callForgetPassword(Function onSuccess, Function onError,String password,String phone) {
    EndPoint.shared
        .setMethodType(RequestType.post)
        .setNeedAuth(false)
        .callStreamRequest('post', ForgetPassword,json.encode({
      'phone': phone,
      'password': password,
      "firebase_token":Base_fcm,
      "access_token":Jwt_token,
    }),(json) {
      print("res = "+json.toString());
      RegisterResponseModel.fromJson(json);
    },
        contentType: APPLICATION_JSON)
        .then((stream) {
      stream.listen((data) => onSuccess(data));
    }).catchError((error) => onError(error));
  }
}