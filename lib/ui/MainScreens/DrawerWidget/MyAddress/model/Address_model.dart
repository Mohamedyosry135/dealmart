class AddressModel {
  List<Adress> success;
  int code;

  AddressModel({this.success, this.code});

  AddressModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] != null) {
      success = new List<Adress>();
      json['success'].forEach((v) {
        success.add(new Adress.fromJson(v));
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

class Adress {
  int id;
  String createdAt;
  String updatedAt;
  String address;




  String lat;
  String lng;
  int isDefault;
  int userId;

  String firstName;
  String lastName;
  String phone;

  Adress(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.address,
        this.lat,
        this.lng,
        this.isDefault,
        this.userId,this.firstName,this.lastName,this.phone});

  Adress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    isDefault = json['isDefault'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['isDefault'] = this.isDefault;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;


    return data;
  }
}