import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shop_app/Cache/Shared_Preferance.dart';
import 'package:shop_app/Reuseable_Components/reusable%20text.dart';
import 'package:shop_app/Screens/Search_Screen/Search_Screen.dart';
import 'package:shop_app/Screens/login/login.dart';
import 'package:shop_app/Screens/person_info/person_Info.dart';
import 'package:shop_app/constance/constance.dart';
import 'package:shop_app/main_cubit/main_cubit.dart';
import 'package:shop_app/main_cubit/main_state.dart';

class HomeScreen extends StatelessWidget {
  String? image = '';
  String? name = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        SystemChrome.setEnabledSystemUIOverlays([]);

        var cubit = MainCubit.get(context);
        if (state is ProfileInfoSuccess) name = state.profileModel!.data!.name;
        if (state is ProfileInfoSuccess)
          image = state.profileModel!.data!.image;
        if (state is UpdateProfileSuccess)
          name = state.profileModel!.data!.name;
        if (state is UpdateProfileSuccess)
          image = state.profileModel!.data!.image;
        return Scaffold(
          drawerScrimColor: primarySwatch,
          drawer: Drawer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SafeArea(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: primarySwatch,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            color: Colors.black,
                            onPressed: () {
                              cubit.getProfileData();
                            },
                            icon: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 30.0,
                                child: Icon(
                                  Icons.restart_alt,
                                  color: Colors.white,
                                ))),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: double.infinity,
                    color: primarySwatch,
                    child: DrawerHeader(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage: NetworkImage('$image'),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '$name',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                          maxLines: 1,
                        )
                      ],
                    )),
                  ),
                ),
                ListTile(
                  title: Text('home'),
                  leading: Icon(Icons.home),
                ),
                ListTile(
                  title: Text('Settings'),
                  leading: Icon(Icons.settings),
                ),
                ListTile(
                  onTap: () {
                    cubit.getProfileData();
                    navigateTo(context, PersonInfo());
                  },
                  title: Text('Profile Info'),
                  leading: Icon(Icons.person),
                ),
                Spacer(),
                Center(
                  child: MaterialButton(
                    elevation: 5,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    minWidth: MediaQuery.of(context).size.width / 2,
                    height: 40.0,
                    color: primarySwatch,
                    onPressed: () {
                      CacheHelper.removeData(key: token!).then((value) {
                        if (value) {
                          navigateAndRemove(context, LoginScreen());
                        }
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'LOG OUT',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: primarySwatch,
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  })
            ],
            title: AutoSizeText(
              'MARKET',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30.0,
                  color: Colors.white),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.items,
            onTap: (index) {
              cubit.changeIndex(index);
            },
          ),
          body: SmartRefresher(
            enablePullUp: true,
            enablePullDown: true,
            header: MaterialClassicHeader(),
            footer: CustomFooter(
              builder: (context, LoadStatus? mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = Text("pull up load");
                } else if (mode == LoadStatus.loading) {
                  body = CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = Text("Load Failed!Click retry!");
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("release to load more");
                } else {
                  body = Text("No more Data");
                }
                return Container(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            child: cubit.pages[cubit.currentIndex],
            controller: cubit.refreshController,
            onRefresh: cubit.onRefresh,
            onLoading: cubit.onLoading,
          ),
        );
      },
    );
  }
}
