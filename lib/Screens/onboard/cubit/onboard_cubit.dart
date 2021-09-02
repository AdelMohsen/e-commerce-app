import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Reuseable_Components/reusable%20text.dart';
import 'package:shop_app/Screens/onboard/cubit/onboard_state.dart';

class OnboardCubit extends Cubit<OnBoardState> {
  OnboardCubit() : super(InitState());

  static OnboardCubit get(context) => BlocProvider.of(context);

  var boardController = PageController();

  List<String> hText = ['Online shopping', 'Add to cart', 'Payment Successful'];

  List<String> sText = [
    'Women Fashion Shopping Online - Shop from a huge range of latest women clothing, shoes, makeup Kits, Watches, footwear and more for women at best price',
    'Add to cart button works on product pages. The customizations in this section  compatible with dynamic checkout buttons',
    'Your payment has been successfully completed. You will receive a confirmation email within a few minutes. '
  ];

  List<String> images = [
    'assets/images/onboard/onboard_1.png',
    'assets/images/onboard/onboard_2.png',
    'assets/images/onboard/onboard_3.png'
  ];

  bool isLast = false;

  onChanged(int onChanged) {
    if (onChanged == hText.length - 1) {
      isLast = true;
    } else {
      isLast = false;
    }
  }

  Widget pageView(
          {required context,
          required String image,
          required String hText,
          required String sText}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
              child: Column(
                children: [
                  Image(image: AssetImage(image)),
                  SizedBox(
                    height: 40.0,
                  ),
                  Center(
                    child: headText(text: hText),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width - 50,
                        child: smallText(text: sText)),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Row(
              children: [
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
                      submit(context);
                    } else {
                      boardController.nextPage(
                          duration: Duration(milliseconds: 700),
                          curve: Curves.fastOutSlowIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          )
        ],
      );
}
