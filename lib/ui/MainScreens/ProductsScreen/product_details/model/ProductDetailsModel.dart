class ProductDetailsModel {
  ProductDetails success;
  int code;

  ProductDetailsModel({this.success, this.code});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    success =
    json['success'] != null ? new ProductDetails.fromJson(json['success']) : null;
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

class ProductDetails {
  int id;
  var createdAt;
  String updatedAt;
  String name;
  String description;
  int sold;
  int amount;
  String price;
  int numberPhotos;
  int isFavourit;
  Gift gift;

  ProductDetails(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.description,
        this.sold,
        this.amount,
        this.price,
        this.numberPhotos,
        this.isFavourit,
        this.gift});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    description = json['description'];
    sold = json['sold'];
    amount = json['amount'];
    price = json['price'];
    numberPhotos = json['number_photos'];
    isFavourit = json['isFavourit'];

    gift = json['gift'] != null ? new Gift.fromJson(json['gift']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['description'] = this.description;
    data['sold'] = this.sold;
    data['amount'] = this.amount;
    data['price'] = this.price;
    data['number_photos'] = this.numberPhotos;
    data['isFavourit'] = this.isFavourit;
    if (this.gift != null) {
      data['gift'] = this.gift.toJson();
    }
    return data;
  }
}

class Gift {
  int id;
  var createdAt;
  var updatedAt;
  int productId;
  int giftProductId;
  Winner winner;
  GiftProduct giftProduct;

  Gift(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.productId,
        this.giftProductId,
        this.winner,
        this.giftProduct});

  Gift.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productId = json['product_id'];
    giftProductId = json['gift_product_id'];
    winner = json['winner'];
    giftProduct = json['gift_product'] != null
        ? new GiftProduct.fromJson(json['gift_product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product_id'] = this.productId;
    data['gift_product_id'] = this.giftProductId;
    data['winner'] = this.winner;
    if (this.giftProduct != null) {
      data['gift_product'] = this.giftProduct.toJson();
    }
    return data;
  }
}

class GiftProduct {
  int id;
  var createdAt;
  String updatedAt;
  String name;
  String description;
  int sold;
  int amount;
  String price;
  int numberPhotos;

  GiftProduct(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.description,
        this.sold,
        this.amount,
        this.price,
        this.numberPhotos});

  GiftProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    description = json['description'];
    sold = json['sold'];
    amount = json['amount'];
    price = json['price'];
    numberPhotos = json['number_photos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['description'] = this.description;
    data['sold'] = this.sold;
    data['amount'] = this.amount;
    data['price'] = this.price;
    data['number_photos'] = this.numberPhotos;
    return data;
  }
}

class Winner {
  int id;
  String createdAt;
  String updatedAt;
  int giftId;
  int userId;
  String announceDate;
  User user;

  Winner(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.giftId,
        this.userId,
        this.announceDate,
        this.user});

  Winner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    giftId = json['gift_id'];
    userId = json['user_id'];
    announceDate = json['announce_date'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['gift_id'] = this.giftId;
    data['user_id'] = this.userId;
    data['announce_date'] = this.announceDate;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String socialId;
  String fullName;
  int isGoogleOrFacebookAccount;
  var firebaseToken;
  var profilePicture;
  var phone;
  String email;
  var emailVerifiedAt;
  var salt;
  int role;
  String createdAt;
  String updatedAt;

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