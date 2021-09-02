class PostFavData{
  bool? status;
  String? message;
  PostFavData.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}