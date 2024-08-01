import 'package:dealmart/api/model/BaseApiResponse.dart';

class RegisterResponseModel extends BaseApiResponse{
  RegisterResponseModel({code,msg}) : super(code,msg);
  String accessToken;
  String tokenType;
  int code;


  RegisterResponseModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    code = json['code'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    return data;
  }

}