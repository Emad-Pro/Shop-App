class ShopLoginModel {
  bool? Status;
  String? Message;
  UserData? data;
  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    Status = json['status'];
    Message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  dynamic credit;
  String? token;
  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    credit = json['credit'];
    token = json['token'];
  }
}
