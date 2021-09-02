class HomeModel {
  bool? status;
  String? message;
  DataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? DataModel.fromJson(json['data']) : null;
  }
}

class DataModel {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];

  DataModel.fromJson(Map<String, dynamic> json) {
    banners=(json['banners'] as List).map((e) => BannersModel.fromJson(e)).toList();
    products=(json['products'] as List).map((e) => ProductsModel.fromJson(e)).toList();
  }
}

class BannersModel {
  int? id;
  String? image;

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavourites;
  bool? inCart;
  String? description;
  List imagesList=[];

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavourites = json['in_favorites'];
    inCart = json['in_cart'];
    description=json['description'];
    (json['images']as List).addAll(imagesList);

  }
}
