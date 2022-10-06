class HomeModel {
  late bool status;
  HomeDataModel? data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerClass>? Banners = [];
  List<ProductsClass>? Products = [];
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      Banners!.add(BannerClass.fromJson(element));
    });
    json['products'].forEach((element) {
      Products!.add(ProductsClass.fromJson(element));
    });
  }
}

class BannerClass {
  int? id;
  String? image;

  BannerClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsClass {
  int? id;
  dynamic price, oldPrice, discount;
  String? image, name;
  bool? favorites, inCart;
  ProductsClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    favorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
