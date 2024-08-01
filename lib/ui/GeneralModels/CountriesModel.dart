
class CountriesModel {
  List<CountriesData> success;
  int code;

  CountriesModel({this.success, this.code});

  CountriesModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] != null) {
      success = new List<CountriesData>();
      json['success'].forEach((v) {
        success.add(new CountriesData.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class CountriesData {
  int id;
  String callingCode;
  String currencyName;
  String currencyCode;
  String currencySymbol;
  String countryNameAr;
  String countryNameEn;
  String flag;
  String alpha2Code;
  Fee fee;

  CountriesData(
      {this.id,
        this.callingCode,
        this.currencyName,
        this.currencyCode,
        this.currencySymbol,
        this.countryNameAr,
        this.countryNameEn,
        this.flag,
        this.alpha2Code,
        this.fee});

  CountriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    callingCode = json['calling_code'];
    currencyName = json['currency_name'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    countryNameAr = json['country_name_ar'];
    countryNameEn = json['country_name_en'];
    flag = json['flag'];
    alpha2Code = json['alpha2Code'];
    fee = json['fee'] != null ? new Fee.fromJson(json['fee']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['calling_code'] = this.callingCode;
    data['currency_name'] = this.currencyName;
    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    data['country_name_ar'] = this.countryNameAr;
    data['country_name_en'] = this.countryNameEn;
    data['flag'] = this.flag;
    data['alpha2Code'] = this.alpha2Code;
    if (this.fee != null) {
      data['fee'] = this.fee.toJson();
    }
    return data;
  }
}

class Fee {
  int id;
  Null createdAt;
  Null updatedAt;
  String rechargeFeesAmount;
  String orderFeesAmount;
  int countryId;

  Fee(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.rechargeFeesAmount,
        this.orderFeesAmount,
        this.countryId});

  Fee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    rechargeFeesAmount = json['recharge_fees_amount'];
    orderFeesAmount = json['order_fees_amount'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['recharge_fees_amount'] = this.rechargeFeesAmount;
    data['order_fees_amount'] = this.orderFeesAmount;
    data['country_id'] = this.countryId;
    return data;
  }
}
