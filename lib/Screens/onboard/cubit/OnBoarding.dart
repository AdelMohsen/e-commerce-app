import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Reuseable_Components/reusable%20text.dart';
import 'package:shop_app/Screens/onboard/cubit/onboard_cubit.dart';
import 'package:shop_app/Screens/onboard/cubit/onboard_state.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardCubit(),
      child: BlocConsumer<OnboardCubit, OnBoardState>(
        listener: (context, state) {},
        builder: (context, state) {
          OnboardCubit cubit = OnboardCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: () {
                     submit(context);
                    },
                    child: Text('SKIP'))
              ],
            ),
            body: PageView.builder(
                onPageChanged: (onChanged) {
                  cubit.onChanged(onChanged);
                },
                controller: cubit.boardController,
                physics: BouncingScrollPhysics(),
                itemCount: cubit.hText.length,
                itemBuilder: (context, index) => cubit.pageView(
                    context: context,
                    hText: cubit.hText[index],
                    sText: cubit.sText[index],
                    image: cubit.images[index])),
          );
        },
      ),
    );
  }
}
