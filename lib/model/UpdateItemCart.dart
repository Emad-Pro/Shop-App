class UpdateItemCartModel {
  bool? status;
  String? message;
  Data? data;

  UpdateItemCartModel({this.status, this.message, this.data});

  UpdateItemCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  CartItem? cart;
  dynamic subTotal;
  dynamic total;

  Data.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? new CartItem.fromJson(json['cart']) : null;
    subTotal = json['sub_total'];
    total = json['total'];
  }
}

class CartItem {
  int? id;
  int? quantity;
  Product? product;

  CartItem({this.id, this.quantity, this.product});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
}
