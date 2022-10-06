class AddOrderModel {
  bool? status;
  dynamic message;
  Data? data;

  AddOrderModel({this.status, this.message, this.data});

  AddOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? paymentMethod;
  dynamic cost;
  dynamic vat;
  dynamic discount;
  dynamic points;
  dynamic total;
  dynamic id;

  Data.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    cost = json['cost'];
    vat = json['vat'];
    discount = json['discount'];
    points = json['points'];
    total = json['total'];
    id = json['id'];
  }
}
