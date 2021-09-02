import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/Home/cubit/home_cubit.dart';
import 'package:shop_app/Screens/Home/cubit/home_state.dart';
import 'package:expandable/expandable.dart';

class ProductsDetails extends StatelessWidget {
  final int index;

  ProductsDetails(this.index);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
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
            title: Text('${cubit.homeModel!.data!.products[index].name}'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Image(
                      image: NetworkImage(
                          '${cubit.homeModel!.data!.products[index].image}'),
                    ),
                    ExpandablePanel(
                      header: Text(
                        '${cubit.homeModel!.data!.products[index].name}',
                        style: TextStyle(color: Colors.black),
                      ),
                      collapsed: Text(
                        '${cubit.homeModel!.data!.products[index].description}',
                        style: TextStyle(color: Colors.grey),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      expanded: Text(
                        '${cubit.homeModel!.data!.products[index].description}',
                        style: TextStyle(color: Colors.grey),
                        softWrap: true,
                      ),
                    ),
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
