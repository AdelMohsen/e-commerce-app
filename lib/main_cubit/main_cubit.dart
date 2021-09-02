import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shop_app/Models/CategoriesModel/categories_model.dart';
import 'package:shop_app/Models/home_models/data_model.dart';
import 'package:shop_app/Models/login/Login_Models.dart';
import 'package:shop_app/Models/profile/get_profile_info.dart';
import 'package:shop_app/Network/dio_helper/dio_helper.dart';
import 'package:shop_app/Screens/Home/home_products.dart';
import 'package:shop_app/Screens/ShoppingCart/Shopping_Cart.dart';
import 'package:shop_app/Screens/categories/categories.dart';
import 'package:shop_app/Screens/favourites/favourits.dart';
import 'package:shop_app/constance/constance.dart';
import 'package:shop_app/constance/end_point.dart';
import 'package:shop_app/main_cubit/main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitialState());

  static MainCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  ProfileModel? profileModel;
  ShopLoginModel? shopLoginModel;
  CategoriesModel? categoriesModel;
  late HomeModel homeModel;
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart), label: 'Shopping Cart'),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(HomeBottomNavState());
  }

  List<Widget> pages = [
    HomeProducts(),
    CategoriesScreen(),
    FavouritesScreen(),
    ShoppingCartScreen()
  ];

  getProfileData() {
    emit(ProfileInfoLoading());
    DioHelper.getData(
      url: Profile,
      lang: 'en',
      token: token,
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      print(profileModel!.data!.name);
      token = profileModel!.data!.token;
      emit(ProfileInfoSuccess(profileModel));
    }).catchError((error) {
      print(error.toString());
      emit(ProfileInfoError());
    });
  }

  updateUserData({name, phone, email, password}) {
    emit(UpdateProfileLoading(profileModel));
    DioHelper.putData(
            url: UpdateProfile,
            data: {
              'name': name,
              'phone': phone,
              'email': email,
              'password': password,
            },
            token: token,
            lang: 'en')
        .then((value) {
      if (value.data['status'] == false) {
        emit(UpdateProfileError(profileModelMessage: value.data['message']));
      } else {
        profileModel = ProfileModel.fromJson(value.data);
        emit(UpdateProfileSuccess(profileModel));
      }
    }).catchError((error) {
      print(error.toString());
      emit(UpdateProfileError(profileModel: profileModel));
    });
  }

  getCategoriesDate() {
    emit(CategoriesLoadingDataState());
    DioHelper.getData(url: Categories, token: token, lang: 'en').then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(CategoriesSuccessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(CategoriesErrorDataState());
    });
  }

  Map<int?, bool?> favourites = {};
  Map<int?, bool?> cart = {};

  getHomeData() {
    emit(HomeLoadingState());
    DioHelper.getData(url: 'home', token: token, lang: 'en').then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data!.products.forEach((element) {
        favourites.addAll({element.id: element.inFavourites});
      });
      homeModel.data!.products.forEach((element) {
        cart.addAll({element.id: element.inCart});
      });
      emit(HomeSuccessState());
    }).catchError((error) {
      emit(HomeErrorState());
      print(error.toString());
    });
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    getCategoriesDate();
    getHomeData();
    emit(RefreshSuccessState());
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    emit(RefreshLoadingState());
    refreshController.loadComplete();
  }



}
