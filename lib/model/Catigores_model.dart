class CatigoresModel {
  bool? status;
  CatigoresDataModel? data;
  CatigoresModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CatigoresDataModel.fromJson(json['data']);
  }
}

class CatigoresDataModel {
  int? current_page;
  List<DataModel>? data = [];
  CatigoresDataModel.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data!.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  int? id;
  dynamic name;
  dynamic image;
  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
