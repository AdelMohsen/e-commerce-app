class GetCartModel {
  bool? status;
  String? message;
  late GetCartData data;

  GetCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = GetCartData.fromJson(json['data']);
  }
}

class GetCartData {
  dynamic total;
  dynamic subTotal;
  List<CartItems> cartItems = [];

  GetCartData.fromJson(Map<String, dynamic> json) {
    cartItems =
        (json['cart_items'] as List).map((e) => CartItems.fromJson(e)).toList();
    total = json['total'];
    subTotal = json['sub_total'];
  }
}

class CartItems {
  int? quantity;

  late CartProductsInfo products;

  CartItems.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    products = CartProductsInfo.fromJson(json['product']);
  }
}

class CartProductsInfo {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;

  String? description;
  bool? inCart;
  bool? inFavourites;

  CartProductsInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inCart = json['in_favorites'];
    inFavourites = json['in_cart'];
  }
}
