class BaseApiResponse {
  int code = 200;
  String msg;

  BaseApiResponse(this.code,this.msg);

  BaseApiResponse.fromJson(Map<String, dynamic> json) {

    print('BaseApiResponse '+json.toString());

    if(json!=null){
      code = json['code'];
      msg = json['msg']??json['error'];
    }

  }

  String get status => code.toString() ;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    return data;
  }

}

