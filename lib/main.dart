import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cache/Shared_Preferance.dart';
import 'package:shop_app/Network/dio_helper/dio_helper.dart';
import 'package:shop_app/Screens/Home/Home_layout.dart';
import 'package:shop_app/Screens/Home/cubit/home_cubit.dart';
import 'package:shop_app/Screens/login/login.dart';
import 'package:shop_app/Screens/onboard/cubit/OnBoarding.dart';
import 'package:shop_app/Screens/regiester_screen/cubit/register_cubit.dart';
import 'package:shop_app/constance/constance.dart';
import 'package:shop_app/main_cubit/main_cubit.dart';
import 'package:shop_app/main_cubit/main_state.dart';
import 'package:shop_app/observer/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  bool? onBoarding = CacheHelper.readData(key: "onBoarding");
  token = CacheHelper.readData(key: "token");
  print(token);
  if (onBoarding != null) {
    if (token != null)
      widget = HomeScreen();
    else
      widget = LoginScreen();
  } else
    widget = OnBoarding();

  runApp(Home(
    onBoarding: widget,
  ));
}

class Home extends StatelessWidget {
  final Widget? onBoarding;

  Home({this.onBoarding});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          if (token != null)
            return MainCubit()..getProfileData();
          else
            return MainCubit();
        }),
        BlocProvider(
            create: (context) => HomeCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavouritesData()
              ..getCartData()),
        BlocProvider(create: (context) => RegisterCubit())
      ],
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: onBoarding,
          );
        },
      ),
    );
  }
}
