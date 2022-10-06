class GetOrderDetilsModel {
  bool? status;
  dynamic message;
  Data? data;

  GetOrderDetilsModel({this.status, this.message, this.data});

  GetOrderDetilsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  dynamic cost;
  int? discount;
  dynamic points;
  dynamic vat;
  dynamic total;
  int? pointsCommission;
  String? promoCode;
  String? paymentMethod;
  String? date;
  String? status;
  Address? address;
  List<ProductsItem>? products;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cost = json['cost'];
    discount = json['discount'];
    points = json['points'];
    vat = json['vat'];
    total = json['total'];
    pointsCommission = json['points_commission'];
    promoCode = json['promo_code'];
    paymentMethod = json['payment_method'];
    date = json['date'];
    status = json['status'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['products'] != null) {
      products = <ProductsItem>[];
      json['products'].forEach((v) {
        products!.add(new ProductsItem.fromJson(v));
      });
    }
  }
}

class Address {
  int? id;
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  dynamic latitude;
  dynamic longitude;

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    notes = json['notes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
}

class ProductsItem {
  int? id;
  int? quantity;
  dynamic price;
  String? name;
  String? image;

  ProductsItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    price = json['price'];
    name = json['name'];
    image = json['image'];
  }
}
