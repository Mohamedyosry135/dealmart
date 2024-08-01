import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dealmart/api/remote/API_PATHS.dart';
import 'package:dealmart/api/remote/EndPoint.dart';
import 'package:dealmart/ui/MainScreens/ProfileScreen/model/EditProfileResponse.dart';
import 'package:dealmart/ui/signUp/model/RegisterResponseModel.dart';
import 'package:dealmart/utils/shared_utils.dart';
import 'package:dio/dio.dart';

class UpdateProfileBloc{
  var dio = Dio();
  void callUpdateProfile(Function onSuccess, Function onError,String full_name,String phone,String email,String password) {
  EndPoint.shared
      .setMethodType(RequestType.post)
      .setNeedAuth(true)
      .callStreamRequest('post', UPDATEAPI,(password != null || password!= '')?
  json.encode({
  'full_name': full_name,
  'phone': phone,
  'email': email,
  'password': password,
  }):
  json.encode({
    'full_name': full_name,
    'phone': phone,
    'email': email
  })
      ,(json) => EditProfileResponse.fromJson(json),
  contentType: APPLICATION_JSON)
      .then((stream) {

        print("streamstream ${stream}");
  stream.listen((data) => onSuccess(data));
  }).catchError((error) => onError(error));
  }
  Future<String> callUpdatePassword(String oldPassword,String newPassword,bool isSocial) async{
    try {
      final response = await http.post(
          "https://dealmart.herokuapp.com${CHANGEPASSWORDAPI}",
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${userToken}"
          },
          body:isSocial?  {
            "new_password" : newPassword
          }:{
            "old_password" : oldPassword,
            "new_password" : newPassword
          }
      );

      if(response.statusCode == 200){
        return "200";
      }else{
        return "${json.decode(response.body)['error']}";
      }

    }
    catch(e){
      print("RepoError ${e}");
      return "Response Error";

      //throw e;
    }
  }

  void callUpdateImage(Function onSuccess, Function onError,File image)async{
    FormData formData = new FormData.fromMap({
      "profile_picture": await MultipartFile.fromFile(image.path,filename: image.path),
    });

    dio.post('https://dealmart.herokuapp.com/api/set/profile/picture',
        data: formData,
        options: Options(
        method:'',
            headers:{
          "Authorization": "Bearer " + userToken
            })
    ).then((response) => onSuccess(response))
        .catchError((error) =>
        onError(error));
  }


}