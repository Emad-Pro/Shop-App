class AddAdressModel {
  bool? status;
  String? message;
  Data? data;

  AddAdressModel({this.status, this.message, this.data});

  AddAdressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  String? latitude;
  String? longitude;
  int? id;

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    notes = json['notes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    id = json['id'];
  }
}
