import 'package:shop_app/Models/Register_Screen/RegisterPostModel.dart';

class RegisterStates {}

class RegisterInitialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{
PostRegisterModel? postRegisterModel;

RegisterSuccessState(this.postRegisterModel);


}

class RegisterErrorState extends RegisterStates{
  PostRegisterModel? postRegisterModel;

  RegisterErrorState(this.postRegisterModel);
}

class ShowPassword extends RegisterStates{}
