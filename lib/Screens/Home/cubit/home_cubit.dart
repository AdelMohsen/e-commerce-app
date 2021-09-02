import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/Cart_Model/Get_Data.dart';
import 'package:shop_app/Models/Cart_Model/Post_Data.dart';
import 'package:shop_app/Models/CategoriesModel/categories_model.dart';
import 'package:shop_app/Models/favourites_model/Get_Data.dart';
import 'package:shop_app/Models/favourites_model/post_data.dart';
import 'package:shop_app/Models/home_models/data_model.dart';
import 'package:shop_app/Models/profile/get_profile_info.dart';
import 'package:shop_app/Network/dio_helper/dio_helper.dart';
import 'package:shop_app/Screens/Home/cubit/home_state.dart';
import 'package:shop_app/constance/constance.dart';
import 'package:shop_app/constance/end_point.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

    HomeModel? homeModel;
  PostFavData? postFavData;
  CategoriesModel? categoriesModel;
  late GetAllFavData getFavData;
  PostCartModel? postCartModel;
  late GetCartModel getCartModel;
  ProfileModel? profileModel;


  Map<int?, bool?> favourites = {};
  Map<int?, bool?> cart = {};

  getHomeData() {
    emit(HomeLoadingState());
    DioHelper.getData(url: 'home', token: token, lang: 'en').then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favourites.addAll({element.id: element.inFavourites});
      });
      homeModel!.data!.products.forEach((element) {
        cart.addAll({element.id: element.inCart});
      });
      emit(HomeSuccessState());
    }).catchError((error) {
      emit(HomeErrorState());
      print(error.toString());
    });
  }

  getCategoriesData() {
    DioHelper.getData(url: Categories, lang: 'en', token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(HomeCategoriesSuccessState());
    }).catchError((error) {
      emit(HomeCategoriesErrorState());
      print(error.toString());
    });
  }

  getFavouritesData() {
    DioHelper.getData(
      url: Favourites,
      token: token,
      lang: 'en',
    ).then((value) {
      getFavData = GetAllFavData.fromJson(value.data);

      emit(HomeFavouritesSuccess(postFavData));
    }).catchError((error) {
      print(error.toString());
      emit(HomeFavouritesError(postFavData));
    });
  }

  getCartData() {
    DioHelper.getData(
      url: Carts,
      token: token,
      lang: 'en',
    ).then((value) {
      getCartModel = GetCartModel.fromJson(value.data);
      emit(HomeCartSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(HomeCartError());
    });
  }



  changeFavIcon(int? productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ChangeFavIcon());
    DioHelper.postData(
            url: Favourites, data: {'product_id': productId}, token: token)
        .then((value) {
      postFavData = PostFavData.fromJson(value.data);
      if (!postFavData!.status!) {
        favourites[productId] = !favourites[productId]!;
      }
      emit(ChangeSuccessFavIcon());
      getFavouritesData();
    }).catchError((error) {
      favourites[productId] = !favourites[productId]!;
      emit(ChangeErrorFavIcon(postFavData));
      print(error.toString());
    });
  }

  sendToCart(int? productId) {
    cart[productId] = !cart[productId]!;
    emit(SendToCartLoading());
    DioHelper.postData(
      url: Carts,
      data: {'product_id': productId},
      token: token,
      lang: 'en',
    ).then((value) {
      postCartModel = PostCartModel.fromJson(value.data);
      if (!postCartModel!.status!) {
        cart[productId] = !cart[productId]!;
      }
      print(postCartModel!.message);
      getCartData();
      emit(SendToCartSuccess(postCartModel));
    }).catchError((error) {
      cart[productId] = !cart[productId]!;
      print(error.toString());
      emit(SendToCartError(postCartModel));
    });
  }
}
