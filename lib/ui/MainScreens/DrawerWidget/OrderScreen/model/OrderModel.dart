class OrderModel {
  List<Order> orders;
  int code;

  OrderModel({this.orders, this.code});

  OrderModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] != null) {
      orders = new List<Order>();
      json['success'].forEach((v) {
        orders.add(new Order.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['success'] = this.orders.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class Order {
  int id;
  String createdAt;
  String updatedAt;
  int amount;
  int state;
  String cost;
  int userId;
  int productId;
  Product product;

  Order(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.amount,
        this.state,
        this.cost,
        this.userId,
        this.productId,
        this.product});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    amount = json['amount'];
    state = json['state'];
    cost = json['cost'];
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
    data['state'] = this.state;
    data['cost'] = this.cost;
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
  Null createdAt;
  String updatedAt;
  String name;
  String description;
  int sold;
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
        this.sold,
        this.amount,
        this.price,this.isFavourit,
        this.numberPhotos});

  Product.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}