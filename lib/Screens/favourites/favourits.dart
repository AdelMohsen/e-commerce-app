import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Models/favourites_model/Get_Data.dart';
import 'package:shop_app/Screens/Home/cubit/home_cubit.dart';
import 'package:shop_app/Screens/Home/cubit/home_state.dart';
import 'package:shop_app/constance/constance.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeFavouritesSuccess) {
          Fluttertoast.showToast(
              msg: state.postFavData!.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (state is HomeFavouritesError) {
          Fluttertoast.showToast(
              msg: state.postFavData!.message,
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
          conditionBuilder: (context) => cubit.getFavData.data.data.length != 0,
          widgetBuilder: (context) => favouritesBuilder(cubit.getFavData),
          fallbackBuilder: (context) => Center(
            child: Image(image: AssetImage('assets/images/cart/WishList.png')),
          ),
        );
      },
    );
  }
}

favouritesBuilder(GetAllFavData favModel) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 100,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                      height: 100.0,
                      width: 100.0,
                      image: NetworkImage(
                          "${favModel.data.data[index].products.image}")),
                  if (favModel.data.data[index].products.discount != 0)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      color: primarySwatch,
                      child: Text(
                        'Discount',
                        style: TextStyle(color: Colors.white, fontSize: 10.0),
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
                      '${favModel.data.data[index].products.name}',
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
                            '${favModel.data.data[index].products.price}',
                            style:
                                TextStyle(color: primarySwatch, fontSize: 15),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          if (favModel.data.data[index].products.discount != 0)
                            Text(
                              '${favModel.data.data[index].products.oldPrice}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          Spacer(),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: HomeCubit.get(context).favourites[
                                    favModel.data.data[index].products.id]!
                                ? primarySwatch
                                : Colors.grey,
                            child: IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  size: 15,
                                  color: HomeCubit.get(context).favourites[
                                          favModel.data.data[index].products.id]!
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                                onPressed: () {
                                  HomeCubit.get(context).changeFavIcon(
                                      favModel.data.data[index].products.id);
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
    itemCount: favModel.data.data.length);
