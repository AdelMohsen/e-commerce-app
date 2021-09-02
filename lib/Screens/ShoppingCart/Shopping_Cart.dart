import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Models/Cart_Model/Get_Data.dart';
import 'package:shop_app/Screens/Home/cubit/home_cubit.dart';
import 'package:shop_app/Screens/Home/cubit/home_state.dart';
import 'package:shop_app/constance/constance.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is SendToCartSuccess) {
          Fluttertoast.showToast(
              msg: state.postCartModel!.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              cubit.getCartModel.data.cartItems.length != 0,
          widgetBuilder: (context) =>
              favouritesBuilder(cubit.getCartModel, context),
          fallbackBuilder: (context) => Center(
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/cart/emptyCart.png'),
            ),
          ),
        );
      },
    );
  }
}

favouritesBuilder(GetCartModel model, context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 100,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                Image(
                                    height: 100.0,
                                    width: 100.0,
                                    image: NetworkImage(
                                        "${model.data.cartItems[index].products.image}")),
                                if (model.data.cartItems[index].products
                                        .discount !=
                                    0)
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    color: primarySwatch,
                                    child: Text(
                                      'Discount',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10.0),
                                    ),
                                  )
                              ],
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${model.data.cartItems[index].products.name}',
                                    style: TextStyle(
                                      height: 1.25,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  Spacer(),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          '${model.data.cartItems[index].products.price}',
                                          style: TextStyle(
                                              color: primarySwatch,
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        if (model.data.cartItems[index].products
                                                .discount !=
                                            0)
                                          Text(
                                            '${model.data.cartItems[index].products.oldPrice}',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                        Spacer(),
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor:
                                              HomeCubit.get(context).cart[model
                                                      .data
                                                      .cartItems[index]
                                                      .products
                                                      .id]!
                                                  ? primarySwatch
                                                  : Colors.grey,
                                          child: IconButton(
                                              icon: Icon(
                                                Icons.shopping_cart,
                                                size: 15,
                                                color: HomeCubit.get(context)
                                                            .cart[
                                                        model
                                                            .data
                                                            .cartItems[index]
                                                            .products
                                                            .id]!
                                                    ? Colors.white
                                                    : Colors.black87,
                                              ),
                                              onPressed: () {
                                                HomeCubit.get(context)
                                                    .sendToCart(model
                                                        .data
                                                        .cartItems[index]
                                                        .products
                                                        .id);
                                              }),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
              separatorBuilder: (context, index) => Divider(
                    color: Colors.black87,
                    height: 1,
                    thickness: 1,
                  ),
              itemCount: model.data.cartItems.length),
        ),
        Container(
          height: 50,
          color: Colors.grey[300],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Total Price :',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                '${model.data.total} L.E',
                style: TextStyle(color: primarySwatch),
              )
            ],
          ),
        ),
      ],
    );
