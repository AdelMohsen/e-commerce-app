import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/Cache/Shared_Preferance.dart';
import 'package:shop_app/Screens/login/login.dart';

Widget headText(
        {required String text,
        FontWeight fontWeight = FontWeight.w400,
        double fonSize = 24.0}) =>
    Text(
      text,
      style: TextStyle(
          fontSize: fonSize,
          fontWeight: fontWeight,
          color: HexColor('#1C1A1A')),
    );

Widget smallText(
        {required String text,
        FontWeight fontWeight = FontWeight.w300,
        double fonSize = 15.0}) =>
    Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: fonSize,
          fontWeight: fontWeight,
          color: HexColor('#707070')),
    );

Widget colorText(
        {required String text,
        FontWeight fontWeight = FontWeight.w300,
        double fonSize = 15.0,
        Color? color}) =>
    Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: fonSize, fontWeight: fontWeight, color: color),
    );

navigateAndRemove(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

Widget customTextFormField(
        {TextEditingController? controller,
        String? labelText,
        String? hintText,
          void Function()? onTap,
        String? Function(String?)? validator,
        void Function(String)? onChanged,
        Widget? preFixIcon,
        TextInputType? keyboardType,
        bool obscure = false,
        Widget? suffixIcon}) =>
    TextFormField(
      keyboardType: keyboardType,
      obscureText: obscure,
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: preFixIcon,
          suffixIcon: suffixIcon),
      onTap:onTap,
      validator: validator,
      onChanged: onChanged,
    );
submit(context) {
  CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
    if (value) {
      navigateAndRemove(context, LoginScreen());
    }
  }).catchError((error) {
    print(error.toString());
  });
}
