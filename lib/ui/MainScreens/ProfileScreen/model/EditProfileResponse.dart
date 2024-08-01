import 'package:dealmart/api/model/BaseApiResponse.dart';

class EditProfileResponse extends BaseApiResponse {
  EditProfileSuccess success;


  EditProfileResponse({code,msg}) : super(code,msg);

  EditProfileResponse.fromJson(Map<String, dynamic> json): super.fromJson(json) {
    print("json['success'] ${json['success']}");
    success = json['success'] != null ? new EditProfileSuccess.fromJson(json['success']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success.toJson();
    }
    return data;
  }
}

class EditProfileSuccess {
  int id;
  String socialId;
  String fullName;
  int isGoogleOrFacebookAccount;
  String firebaseToken;
  String profilePicture;
  String phone;
  String email;
  String emailVerifiedAt;
  String salt;
  int role;
  String createdAt;
  String updatedAt;

  EditProfileSuccess(
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

  EditProfileSuccess.fromJson(Map<String, dynamic> json) {
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