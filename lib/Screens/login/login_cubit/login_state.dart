import 'package:shop_app/Models/login/Login_Models.dart';
import 'package:shop_app/Models/profile/get_profile_info.dart';

abstract class LoginState {}

class LoginInitState extends LoginState{}

class ShowPassword extends LoginState{}

class LoginLoadingState extends LoginState{}
class LoginSuccessState extends LoginState
{
  ShopLoginModel? shopLoginModel;
  LoginSuccessState(this.shopLoginModel);
}
class LoginErrorState extends LoginState{
  LoginErrorState(error);
}

class ProfileInfoLoading extends LoginState{}

class ProfileInfoSuccess extends LoginState{
  final ProfileModel? profileModel;

  ProfileInfoSuccess(this.profileModel);
}


class ProfileInfoError extends LoginState{}