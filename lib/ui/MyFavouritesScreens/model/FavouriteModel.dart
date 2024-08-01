class FavouriteModel {
  List<FavouriteItem> favouriteItem;
  int code;

  FavouriteModel({this.favouriteItem, this.code});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] != null) {
      favouriteItem = new List<FavouriteItem>();
      json['success'].forEach((v) {
        favouriteItem.add(new FavouriteItem.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.favouriteItem != null) {
      data['success'] = this.favouriteItem.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class FavouriteItem {
  int id;
  String createdAt;
  String updatedAt;
  int userId;
  int productId;
  Product product;

  FavouriteItem(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.productId,
        this.product});

  FavouriteItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    productId = json['product_id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class Product {
  int id;
  var createdAt;
  var updatedAt;
  String name;
  String description;
  int amount;
  String price;
  int numberPhotos;
  int isFavourit;

  Product(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.description,
        this.amount,
        this.price,
        this.numberPhotos,this.isFavourit});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    description = json['description'];
    amount = json['amount'];
    price = json['price'];
    numberPhotos = json['number_photos'];
    isFavourit = json['isFavourit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['price'] = this.price;
    data['number_photos'] = this.numberPhotos;
    data['isFavourit'] = this.isFavourit;
    return data;
  }
}