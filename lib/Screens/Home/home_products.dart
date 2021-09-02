import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Models/Cart_Model/Post_Data.dart';
import 'package:shop_app/Models/CategoriesModel/categories_model.dart';
import 'package:shop_app/Models/home_models/data_model.dart';
import 'package:shop_app/Reuseable_Components/reusable%20text.dart';
import 'package:shop_app/Screens/Home/cubit/home_cubit.dart';
import 'package:shop_app/Screens/Home/cubit/home_state.dart';
import 'package:shop_app/Screens/categories/ProductsDeatails.dart';
import 'package:shop_app/constance/constance.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';

class HomeProducts extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is SendToCartSuccess) {
          Fluttertoast.showToast(msg: state.postCartModel!.message);
        } else if (state is SendToCartError) {
          Fluttertoast.showToast(msg: state.postCartModel!.message);
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
            cubit.homeModel != null && cubit.categoriesModel != null,
            widgetBuilder: (context) =>
                productsBuilder(cubit.homeModel!, context,
                    cubit.categoriesModel!, cubit.postCartModel),
            fallbackBuilder: (context) =>
                Center(child: CircularProgressIndicator(),)


        );
      },
    );
  }
}

Widget productsBuilder(HomeModel model, context, CategoriesModel catModel,
    PostCartModel? postCartModel) =>
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model.data!.banners
                  .map((e) =>
                  Image(
                    image: NetworkImage('${e.image}'),
                    fit: BoxFit.cover,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                  ))
                  .toList(growable: true),
              options: CarouselOptions(
                height: 200.0,
                scrollDirection: Axis.horizontal,
                initialPage: 1,
                scrollPhysics: BouncingScrollPhysics(),
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                autoPlayInterval: Duration(seconds: 3),
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: headText(text: 'Categories', fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: 20,
          ),
          categoriesBuilder(catModel),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: headText(text: 'News Products', fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
            color: Colors.black87,
            child: StaggeredGridView.extentBuilder(
              staggeredTileBuilder: (index) => StaggeredTile.extent(1, 350.0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              maxCrossAxisExtent: MediaQuery
                  .of(context)
                  .size
                  .width / 2,
              itemBuilder: (context, index) =>
                  InkWell(
                    onTap: () {
                      navigateTo(context, ProductsDetails(index));
                    },
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomStart,
                            children: [
                              Image(
                                  height: 200.0,
                                  width: double.infinity,
                                  image: NetworkImage(
                                      '${model.data!.products[index].image}')),
                              if (model.data!.products[index].discount != 0)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  color: primarySwatch,
                                  child: AutoSizeText(
                                    'Discount',
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10.0),
                                  ),
                                )
                            ],
                          ),
                          AutoSizeText(
                            '${model.data!.products[index].name}',
                            minFontSize: 13.0,
                            maxFontSize: 15.0,
                            stepGranularity: 1,
                            style: TextStyle(
                              height: 1.25,
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Spacer(),
                          Row(
                            children: [
                              SizedBox(
                                width: 3.0,
                              ),
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                  '${model.data!.products[index].price} L.E',
                                  maxLines: 1,
                                  minFontSize: 10.0,
                                  maxFontSize: 15.0,
                                  stepGranularity: .5,
                                  wrapWords: false,
                                  style: TextStyle(color: primarySwatch),
                                ),
                              ),
                              if (model.data!.products[index].discount != 0)
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    '${model.data!.products[index].oldPrice}L.E',
                                    maxLines: 1,
                                    minFontSize: 7.0,
                                    maxFontSize: 12.0,
                                    stepGranularity: 1.0,
                                    wrapWords: false,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: HomeCubit
                                      .get(context)
                                      .favourites[model.data!.products[index].id]!
                                      ? primarySwatch
                                      : Colors.grey[300],
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        size: 15,
                                        color: HomeCubit
                                            .get(context)
                                            .favourites[
                                        model.data!.products[index].id]!
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                      onPressed: () {
                                        HomeCubit.get(context).changeFavIcon(
                                            model.data!.products[index].id);
                                      }),
                                ),
                              )
                            ],
                          ),
                          Center(
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 2.5,
                              child: MaterialButton(
                                elevation: 3,
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(width: 1.5)),
                                onPressed: () {
                                  HomeCubit.get(context)
                                      .sendToCart(
                                      model.data!.products[index].id);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart,
                                      color: HomeCubit
                                          .get(context)
                                          .cart[model.data!.products[index].id]!
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    Expanded(
                                      child: AutoSizeText(
                                        HomeCubit
                                            .get(context)
                                            .cart[model.data!.products[index].id]!
                                            ? 'Was Added'
                                            : 'Add To Cart',
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: HomeCubit
                                                .get(context)
                                                .cart[
                                            model.data!.products[index].id]!
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                color: HomeCubit
                                    .get(context)
                                    .cart[model.data!.products[index].id]!
                                    ? primarySwatch
                                    : Colors.grey[300],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
              itemCount: model.data!.products.length,
            ),
          )
        ],
      ),
    );

categoriesBuilder(CategoriesModel model) =>
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 100,
      child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12.withOpacity(.5),
                    borderRadius: BorderRadius.circular(4.0)),
                child: Card(
                  elevation: 5.0,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image(
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                          image:
                          NetworkImage('${model.data.data[index].image}')),
                      Container(
                          color: Colors.black.withOpacity(.7),
                          width: 100,
                          height: 30,
                          child: Center(
                            child: AutoSizeText(
                              '${model.data.data[index].name}',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:
                              TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
          separatorBuilder: (context, index) =>
              SizedBox(
                width: 10,
              ),
          itemCount: model.data.data.length),
    );
