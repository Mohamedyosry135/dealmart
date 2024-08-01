class SliderModel {
  Success success;
  int code;

  SliderModel({this.success, this.code});

  SliderModel.fromJson(Map<String, dynamic> json) {
    success =
    json['success'] != null ? new Success.fromJson(json['success']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class Success {
  int id;
  Null createdAt;
  Null updatedAt;
  String title1;
  String title2;
  String title3;
  String fileLink1;
  String fileLink2;
  String fileLink3;

  Success(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.title1,
        this.title2,
        this.title3,
        this.fileLink1,
        this.fileLink2,
        this.fileLink3});

  Success.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title1 = json['title1'];
    title2 = json['title2'];
    title3 = json['title3'];
    fileLink1 = json['file_link1'];
    fileLink2 = json['file_link2'];
    fileLink3 = json['file_link3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['title1'] = this.title1;
    data['title2'] = this.title2;
    data['title3'] = this.title3;
    data['file_link1'] = this.fileLink1;
    data['file_link2'] = this.fileLink2;
    data['file_link3'] = this.fileLink3;
    return data;
  }
}
