import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Cache/Shared_Preferance.dart';
import 'package:shop_app/Reuseable_Components/reusable%20text.dart';
import 'package:shop_app/Screens/Home/Home_layout.dart';
import 'package:shop_app/Screens/login/login_cubit/Login_cubit.dart';
import 'package:shop_app/Screens/login/login_cubit/login_state.dart';
import 'package:shop_app/Screens/regiester_screen/Register_Screen.dart';
import 'package:shop_app/constance/constance.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.shopLoginModel!.status!) {
              print(state.shopLoginModel!.message);
              print(state.shopLoginModel!.data!.token);
              CacheHelper.saveData(
                      key: 'token', value: state.shopLoginModel!.data!.token)
                  .then((value) {
                token = state.shopLoginModel!.data!.token;
                LoginCubit.get(context).getProfileData();
                navigateAndRemove(context, HomeScreen());
              });
            } else {
              Fluttertoast.showToast(
                  msg: state.shopLoginModel!.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        builder: (context, state) {
          var key = GlobalKey<FormState>();
          var loginCubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 100.0, right: 20.0),
                child: Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headText(
                          text: 'LOGIN',
                          fonSize: 30.0,
                          fontWeight: FontWeight.w500),
                      SizedBox(
                        height: 20.0,
                      ),
                      smallText(
                          text: 'Login now to browse our hot offers',
                          fontWeight: FontWeight.w400,
                          fonSize: 18),
                      SizedBox(
                        height: 30.0,
                      ),
                      customTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'check your email !!';
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          labelText: 'Email Address',
                          hintText: 'ahs12@gmail.com',
                          controller: loginCubit.emailController,
                          preFixIcon: Icon(Icons.email_outlined)),
                      SizedBox(
                        height: 22.0,
                      ),
                      customTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'check your password !!';
                            }
                          },
                          suffixIcon: IconButton(
                              icon: loginCubit.icons,
                              onPressed: () {
                                loginCubit.showPassword();
                              }),
                          keyboardType: TextInputType.visiblePassword,
                          obscure: loginCubit.isSecure,
                          labelText: 'Password',
                          hintText: '* * * * * * *',
                          controller: loginCubit.passwordController,
                          preFixIcon: Icon(Icons.lock)),
                      SizedBox(
                        height: 20.0,
                      ),
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            state is! LoginLoadingState,
                        widgetBuilder: (context) => MaterialButton(
                          onPressed: () {
                            if (key.currentState!.validate()) {
                              loginCubit.loginData(
                                  email: loginCubit.emailController.text,
                                  password: loginCubit.passwordController.text);
                            }
                          },
                          child: colorText(
                              text: 'Login',
                              fonSize: 24,
                              fontWeight: FontWeight.w600),
                          minWidth: double.infinity,
                          height: 50.0,
                          color: primarySwatch,
                          textColor: Colors.white,
                        ),
                        fallbackBuilder: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          colorText(
                              text: "Don't have an account?",
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                          TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: colorText(
                                  text: 'REGISTER NOW!!',
                                  color: primarySwatch,
                                  fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
