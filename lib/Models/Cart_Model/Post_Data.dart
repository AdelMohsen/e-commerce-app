class PostCartModel{
  bool? status;
  String? message;
  PostCartData? data;
  
  PostCartModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=PostCartData.fromJson(json['data']);
  }
}

class PostCartData{
  int? quantity;
  PostCartProducts? products;
  PostCartData.fromJson(Map<String,dynamic>json){
    quantity=json['quantity'];
    products = PostCartProducts.fromJson(json['product']);
  }

}

class PostCartProducts{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  PostCartProducts.fromJson(Map<String,dynamic>json){
    id =json['id'];
    price =json['price'];
    oldPrice =json['old_price'];
    discount =json['discount'];
    image =json['image'];
    name =json['name'];
    description =json['description'];
  }
}