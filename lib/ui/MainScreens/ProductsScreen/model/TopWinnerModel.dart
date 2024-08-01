class TopWinnerModel {
  List<TopWinner> topWinner;
  int code;

  TopWinnerModel({this.topWinner, this.code});

  TopWinnerModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] != null) {
      topWinner = new List<TopWinner>();
      json['success'].forEach((v) {
        topWinner.add(new TopWinner.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topWinner != null) {
      data['success'] = this.topWinner.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class TopWinner {
  int userId;
  int total;
  User user;

  TopWinner({this.userId, this.total, this.user});

  TopWinner.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    total = json['total'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['total'] = this.total;
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