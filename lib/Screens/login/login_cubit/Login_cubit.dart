import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/login/Login_Models.dart';
import 'package:shop_app/Models/profile/get_profile_info.dart';
import 'package:shop_app/Network/dio_helper/dio_helper.dart';
import 'package:shop_app/Screens/login/login_cubit/login_state.dart';
import 'package:shop_app/constance/constance.dart';
import 'package:shop_app/constance/end_point.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  ProfileModel? profileModel;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isSecure = true;

  Icon icons = Icon(Icons.visibility_outlined);

  ShopLoginModel? loginModel;

  showPassword() {
    isSecure = !isSecure;
    icons = isSecure
        ? Icon(Icons.visibility_outlined)
        : Icon(Icons.visibility_off_outlined);
    emit(ShowPassword());
  }

  loginData({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(url: Login, data: {
      "email": email,
      "password": password,
    },lang: 'ar').then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    print(error.toString());});
  }

  getProfileData() {
    emit(ProfileInfoLoading());
    DioHelper.getData(
      url: Profile,
      lang: 'en',
      token: token,
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      print(profileModel!.data!.name);
      emit(ProfileInfoSuccess(profileModel));
    }).catchError((error) {
      print(error.toString());
      emit(ProfileInfoError());
    });
  }
}
