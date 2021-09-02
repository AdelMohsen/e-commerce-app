class ProfileModel{
  bool? status;
  String? message;
 GetProfileData? data;
 ProfileModel.fromJson(Map<String,dynamic>json){
   status=json['status'];
   message=json['message'];
   data= json['data']!= null ? GetProfileData.fromJson(json['data']) : null;
 }

}

class GetProfileData{
  int? id;
  String? name;
  String? phone;
  String? email;
  String? image;
  String? token;

  GetProfileData.fromJson(Map <String,dynamic> json){
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'] != null ? json['email'] : null;
    image = json['image'];
    token = json['token'];
  }
}