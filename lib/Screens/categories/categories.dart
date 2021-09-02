import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/CategoriesModel/categories_model.dart';
import 'package:shop_app/Screens/Home/cubit/home_cubit.dart';
import 'package:shop_app/Screens/Home/cubit/home_state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ListView.separated(physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                catBuilder(cubit.categoriesModel!, index),
            separatorBuilder: (context, index) => Divider(
                  height: 5,
                ),
            itemCount: cubit.categoriesModel!.data.data.length);
      },
    );
  }
}

catBuilder(CategoriesModel model, index) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(children: [
        Image(
          image: NetworkImage('${model.data.data[index].image}'),
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20.0,
        ),
        Text(
          '${model.data.data[index].name}',
          style: TextStyle(color: Colors.black),
        ),
        Spacer(),
        IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: () {}),
      ]),
    );
