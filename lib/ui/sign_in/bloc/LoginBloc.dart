import 'dart:convert';

import 'package:dealmart/api/remote/API_PATHS.dart';
import 'package:dealmart/api/remote/EndPoint.dart';
import 'package:dealmart/ui/sign_in/model/LoginResponse.dart';

class LoginBloc {
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  void callLogin(
      Function onSuccess, Function onError, String phone, String password) {

    EndPoint.shared
        .setMethodType(RequestType.post)
        .setNeedAuth(false)
        .callStreamRequest(
            'post',
            LOGINAPI,
            json.encode(isNumeric(phone)
                ? {
                    'phone': phone,
                    'password': password,
                  }
                : {
                    'email': phone,
                    'password': password,
                  }),
            (json) => LoginResponse.fromJson(json),
            contentType: APPLICATION_JSON)
        .then((stream) {
      stream.listen((data) => onSuccess(data));
    }).catchError((error) => onError(error));
  }
}
