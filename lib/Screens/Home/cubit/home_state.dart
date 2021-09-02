import 'package:shop_app/Models/Cart_Model/Post_Data.dart';
import 'package:shop_app/Models/favourites_model/post_data.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeBottomNavState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {}

class HomeErrorState extends HomeStates {}

class HomeCategoriesSuccessState extends HomeStates {}

class HomeCategoriesErrorState extends HomeStates {}

class ChangeFavIcon extends HomeStates{}

class ChangeSuccessFavIcon extends HomeStates{}

class ChangeErrorFavIcon extends HomeStates{
  PostFavData? postFavData;

  ChangeErrorFavIcon(this.postFavData);
}

class HomeFavouritesSuccess extends HomeStates{
  final PostFavData? postFavData;

  HomeFavouritesSuccess(this.postFavData);
}

class HomeFavouritesError extends HomeStates{
  final PostFavData? postFavData;

  HomeFavouritesError(this.postFavData);
}

class SendToCartLoading extends HomeStates{}
class SendToCartSuccess extends HomeStates{
  final PostCartModel? postCartModel;

  SendToCartSuccess(this.postCartModel);
}
class SendToCartError extends HomeStates{
  final PostCartModel? postCartModel;

  SendToCartError(this.postCartModel);
}

class HomeCartSuccess extends HomeStates{}

class HomeCartError extends HomeStates{}

class ProfileInfoLoading extends HomeStates{}

class ProfileInfoSuccess extends HomeStates{}


class ProfileInfoError extends HomeStates{}

