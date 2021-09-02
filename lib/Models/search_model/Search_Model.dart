class SearchModel{
  bool? status;
  String? message;
  DataInfo? data;
  SearchModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data = json['data'] != null? DataInfo.fromJson(json['data']):null;
  }
}

class DataInfo{
  int? currentPage;
  int? total;
  List<ProductsInfo> data = [];
  DataInfo.fromJson(Map<String,dynamic>json){
    currentPage=json['current_page'];
    total=json['total'];
    data=(json['data'] as List).map((e) => ProductsInfo.fromJson(e)).toList();
  }
}

class ProductsInfo{
  int? id;
  dynamic price;
  String? image;
  String? name;
  String? description;
  bool? inFavourites;
  bool? inCart;
  ProductsInfo.fromJson(Map<String,dynamic>json){
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavourites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}

