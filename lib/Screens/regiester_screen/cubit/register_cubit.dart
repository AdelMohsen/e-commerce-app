import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/Register_Screen/RegisterPostModel.dart';
import 'package:shop_app/Network/dio_helper/dio_helper.dart';
import 'package:shop_app/Screens/regiester_screen/cubit/register_state.dart';
import 'package:shop_app/constance/end_point.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var imageController = TextEditingController();

  PostRegisterModel? postRegisterModel;

  postRegisterUserData({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: Register, data: {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    },lang: 'en',).then((value) {
      print(value.toString());
      postRegisterModel = PostRegisterModel.fromJson(value.data);
      emit(RegisterSuccessState(postRegisterModel));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(postRegisterModel));
    });
  }

  bool isSecure = true;

  Icon icons = Icon(Icons.visibility_outlined);

  showPassword() {
    isSecure = !isSecure;
    icons = isSecure
        ? Icon(Icons.visibility_outlined)
        : Icon(Icons.visibility_off_outlined);
    emit(ShowPassword());
  }
}
