import 'package:shop_app/Models/profile/get_profile_info.dart';
abstract class MainState{ }

class MainInitialState extends MainState{}

class HomeBottomNavState extends MainState{}

class HomeLoadingState extends MainState{}

class HomeSuccessState extends MainState{}

class HomeErrorState extends MainState{}

class ProfileInfoLoading extends MainState{}

class ProfileInfoSuccess extends MainState{
  final ProfileModel? profileModel;

  ProfileInfoSuccess(this.profileModel);
}


class ProfileInfoError extends MainState{}

class UpdateProfileLoading extends MainState{
  ProfileModel? profileModel;

  UpdateProfileLoading(this.profileModel);
}
class UpdateProfileSuccess extends MainState{
  ProfileModel? profileModel;

  UpdateProfileSuccess(this.profileModel);
}
class UpdateProfileError extends MainState{
  String? profileModelMessage;
  ProfileModel? profileModel;

  UpdateProfileError({this.profileModel,this.profileModelMessage});
}

class RefreshLoadingState extends MainState{}

class RefreshSuccessState extends MainState{}



class CategoriesLoadingDataState extends MainState{}

class CategoriesSuccessDataState extends MainState{}

class CategoriesErrorDataState extends MainState{}



