import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Cache/Shared_Preferance.dart';
import 'package:shop_app/Reuseable_Components/reusable%20text.dart';
import 'package:shop_app/Screens/login/login.dart';
import 'package:shop_app/Screens/regiester_screen/cubit/register_cubit.dart';
import 'package:shop_app/Screens/regiester_screen/cubit/register_state.dart';
import 'package:shop_app/constance/constance.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          if (state.postRegisterModel!.status!) {
            CacheHelper.saveData(
                    key: 'token', value: state.postRegisterModel!.data!.token)
                .then((value) {
              token = state.postRegisterModel!.data!.token;
              Fluttertoast.showToast(
                  msg: state.postRegisterModel!.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              navigateAndRemove(context, LoginScreen());
            });
          } else {
            Fluttertoast.showToast(
                msg: state.postRegisterModel!.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (context, state) {
        var registerCubit = RegisterCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('back to login screen'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, top: 100.0, right: 20.0),
              child: Form(
                key: registerCubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headText(
                        text: 'OUR OFFERS WAITING YOU...',
                        fonSize: 20.0,
                        fontWeight: FontWeight.w500),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'User Name',
                        suffixIcon: Icon(Icons.verified_user),
                        labelText: 'NAME',
                      ),
                      controller: registerCubit.nameController,
                      validator: (value) =>
                          value!.isEmpty ? 'your name must not be empty' : null,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        suffixIcon: Icon(Icons.phone_android_outlined),
                        labelText: 'NUMBER',
                      ),
                      controller: registerCubit.phoneController,
                      validator: (value) => value!.isEmpty
                          ? 'your number must not be empty'
                          : null,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Enter your email address',
                        suffixIcon: Icon(Icons.email_outlined),
                        labelText: 'EMAIL',
                      ),
                      controller: registerCubit.emailController,
                      validator: (value) =>
                          value!.isEmpty ? 'email must not be empty' : null,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      obscureText: registerCubit.isSecure,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                            icon: registerCubit.icons,
                            onPressed: () {
                              registerCubit.showPassword();
                            }),
                        labelText: 'PASSWORD',
                      ),
                      controller: registerCubit.passwordController,
                      validator: (value) =>
                          value!.isEmpty ? 'password must not be empty' : null,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                        child: Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          state is! RegisterLoadingState,
                      widgetBuilder: (context) => MaterialButton(
                        onPressed: () {
                          if (registerCubit.formKey.currentState!.validate()) {
                            registerCubit.postRegisterUserData(
                              name: registerCubit.nameController.text,
                              phone: registerCubit.phoneController.text,
                              email: registerCubit.emailController.text,
                              password: registerCubit.passwordController.text,
                            );
                            registerCubit.nameController.text = '';
                            registerCubit.phoneController.text = '';
                            registerCubit.emailController.text = '';
                            registerCubit.passwordController.text = '';
                          }
                        },
                        child: Text(
                          'REGISTER',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        color: primarySwatch,
                        minWidth: MediaQuery.of(context).size.width - 50,
                        height: 50.0,
                      ),
                      fallbackBuilder: (context) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
