class TodayWinnerModel {
  List<TodayWinner> todayWinner;
  int code;

  TodayWinnerModel({this.todayWinner, this.code});

  TodayWinnerModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] != null) {
      todayWinner = new List<TodayWinner>();
      json['success'].forEach((v) {
        todayWinner.add(new TodayWinner.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.todayWinner != null) {
      data['success'] = this.todayWinner.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class TodayWinner {
  int id;
  String createdAt;
  String updatedAt;
  int giftId;
  int userId;
  User user;

  TodayWinner(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.giftId,
        this.userId,
        this.user});

  TodayWinner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    giftId = json['gift_id'];
    userId = json['user_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['gift_id'] = this.giftId;
    data['user_id'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  var socialId;
  String fullName;
  int isGoogleOrFacebookAccount;
  var firebaseToken;
  var profilePicture;
  String phone;
  String email;
  var emailVerifiedAt;
  String salt;
  int role;
  var createdAt;
  var updatedAt;

  User(
      {this.id,
        this.socialId,
        this.fullName,
        this.isGoogleOrFacebookAccount,
        this.firebaseToken,
        this.profilePicture,
        this.phone,
        this.email,
        this.emailVerifiedAt,
        this.salt,
        this.role,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    socialId = json['social_id'];
    fullName = json['full_name'];
    isGoogleOrFacebookAccount = json['isGoogleOrFacebookAccount'];
    firebaseToken = json['firebase_token'];
    profilePicture = json['profile_picture'];
    phone = json['phone'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    salt = json['salt'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['social_id'] = this.socialId;
    data['full_name'] = this.fullName;
    data['isGoogleOrFacebookAccount'] = this.isGoogleOrFacebookAccount;
    data['firebase_token'] = this.firebaseToken;
    data['profile_picture'] = this.profilePicture;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['salt'] = this.salt;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}