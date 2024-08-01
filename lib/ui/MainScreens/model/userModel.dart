class UserModel {
  User user;
  int code;

  UserModel({this.user, this.code});

  UserModel.fromJson(Map<String, dynamic> json) {
    user =
    json['success'] != null ? new User.fromJson(json['success']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['success'] = this.user.toJson();
    }
    data['code'] = this.code;
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
  String createdAt;
  String updatedAt;
  Wallet wallet;

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
        this.updatedAt,
        this.wallet});

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
    wallet =
    json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
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
    if (this.wallet != null) {
      data['wallet'] = this.wallet.toJson();
    }
    return data;
  }
}

class Wallet {
  int id;
  int userId;
  String currentBalance;
  String totalSpint;
  String createdAt;
  String updatedAt;

  Wallet(
      {this.id,
        this.userId,
        this.currentBalance,
        this.totalSpint,
        this.createdAt,
        this.updatedAt});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    currentBalance = json['current_balance'];
    totalSpint = json['total_spint'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['current_balance'] = this.currentBalance;
    data['total_spint'] = this.totalSpint;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}