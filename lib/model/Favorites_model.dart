class ChangeFavoritesModel {
  bool? status;
  String? massage;
  ChangeFavoritesModel.fromJason(Map<String, dynamic> json) {
    status = json['status'];
    massage = json['message'];
  }
}
