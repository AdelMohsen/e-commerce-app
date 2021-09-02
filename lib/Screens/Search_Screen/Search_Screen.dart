import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/Search_Screen/cubit/SearchCubit.dart';
import 'package:shop_app/Screens/Search_Screen/cubit/SearchState.dart';
import 'package:shop_app/constance/constance.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
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
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Search',
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)),
                    controller: searchController,
                    onChanged: (String text) {
                      cubit.searchData(text: text);
                    },
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                if (state is SearchLoadingState)
                  LinearProgressIndicator(
                    color: primarySwatch,
                  ),
                SizedBox(
                  height: 5.0,
                ),
                if (state is SearchSuccessState && searchController.text != '')
                  Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                height: 100,
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment:
                                            AlignmentDirectional.bottomStart,
                                        children: [
                                          Image(
                                              height: 100.0,
                                              width: 100.0,
                                              image: NetworkImage(
                                                  "${cubit.searchModel.data!.data[index].image}")),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${cubit.searchModel.data!.data[index].name}',
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
                                                    '${cubit.searchModel.data!.data[index].price}',
                                                    style: TextStyle(
                                                        color: primarySwatch,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Spacer(),
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
                        itemCount: cubit.searchModel.data!.data.length),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
