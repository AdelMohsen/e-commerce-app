import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/search_model/Search_Model.dart';
import 'package:shop_app/Network/dio_helper/dio_helper.dart';
import 'package:shop_app/Screens/Search_Screen/cubit/SearchState.dart';
import 'package:shop_app/constance/constance.dart';
import 'package:shop_app/constance/end_point.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  late SearchModel searchModel;

  searchData({required text}) {
    emit(SearchLoadingState());
    DioHelper.postData(
            url: Search, data: {'text': text}, lang: 'en', token: token)
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
