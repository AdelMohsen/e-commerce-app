import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/constance/constance.dart';
import 'package:shop_app/main_cubit/main_cubit.dart';
import 'package:shop_app/main_cubit/main_state.dart';

class PersonInfo extends StatelessWidget {
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  String? image = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccess) {
          Fluttertoast.showToast(
              msg: state.profileModel!.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is UpdateProfileError) {
          Fluttertoast.showToast(
              msg: state.profileModelMessage,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        var globalKey = GlobalKey<FormState>();
        var cubit = MainCubit.get(context);
        nameController.text = cubit.profileModel!.data!.name!;
        phoneController.text = cubit.profileModel!.data!.phone!;
        emailController.text = cubit.profileModel!.data!.email!;
        if (state is ProfileInfoSuccess) image = state.profileModel!.data!.image;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('Personal Info'),
            centerTitle: true,
            actions: [
              IconButton(
                  color: Colors.black,
                  onPressed: () {
                    cubit.getProfileData();
                  },
                  icon: Icon(
                    Icons.restart_alt,
                  ))
            ],
          ),
          body: Conditional.single(
            context: context,
            conditionBuilder: (context) => state is! ProfileInfoLoading,
            widgetBuilder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: globalKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.0,
                      ),
                      if (state is UpdateProfileLoading)
                        LinearProgressIndicator(
                          color: primarySwatch,
                        ),
                      DrawerHeader(
                          child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage('$image'),
                      )),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'NAME', prefixIcon: Icon(Icons.person)),
                        controller: nameController,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'EMAIL', prefixIcon: Icon(Icons.email)),
                        controller: emailController,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: 'PHONE', prefixIcon: Icon(Icons.phone)),
                        controller: phoneController,
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      MaterialButton(
                        elevation: 5.0,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        onPressed: () {
                          if (globalKey.currentState!.validate()) {
                            cubit.updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        child: Text(
                          'UPDATE',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        minWidth: MediaQuery.of(context).size.width / 1.5,
                        color: primarySwatch,
                        height: 50.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            fallbackBuilder: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
