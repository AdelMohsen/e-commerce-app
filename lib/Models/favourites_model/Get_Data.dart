class GetAllFavData{
  bool? status;
  String? message;
  late FavProductData data;
  GetAllFavData.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=  FavProductData.fromJson(json['data']);

  }
}

class FavProductData{
  int? currentPage;
  List<ProductsData>data=[];
  FavProductData.fromJson(Map<String,dynamic>json){
    currentPage=json['current_page'];
    data=(json['data'] as List).map((e) => ProductsData.from(e)).toList();
  }
}


class ProductsData{
  late ProductsInfo products;
  
  ProductsData.from(Map<String,dynamic>json){
    products=ProductsInfo.fromJson(json['product']);
  }
}

class ProductsInfo{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  ProductsInfo.fromJson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
  }
}