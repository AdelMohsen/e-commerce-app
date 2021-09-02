class PostRegisterModel {
  bool? status;
  String? message;
  PostRegisterData? data;

  PostRegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] !=null ? PostRegisterData.fromJson(json['data']) :null;
  }
}

class PostRegisterData {
  String? name;
  String? phone;
  String? email;
  int? id;
  String? image;
  String? token;

  PostRegisterData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }
}
