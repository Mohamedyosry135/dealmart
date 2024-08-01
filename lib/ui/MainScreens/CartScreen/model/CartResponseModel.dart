import 'package:dealmart/ui/MainScreens/ProductsScreen/model/ProductModel.dart';

class CartResponseModel{

  List<SuccessCart> success;
  int code;

  CartResponseModel({this.success, this.code});

  CartResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] != null) {
      success = new List<SuccessCart>();
      json['success'].forEach((v) {
        success.add(new SuccessCart.fromJson(v));
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

class SuccessCart {
  int id;
  String createdAt;
  String updatedAt;
  int amount;
  int userId;
  int productId;
  Product product;

  SuccessCart(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.amount,
        this.userId,
        this.productId,
        this.product});

  SuccessCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    amount = json['amount'];
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
    data['amount'] = this.amount;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}
