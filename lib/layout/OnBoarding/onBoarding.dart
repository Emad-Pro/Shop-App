import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/layout/login/LoginScreen.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../components/components.dart';
import '../../cubit/onBoardingCubit/cubit.dart';
import '../../cubit/onBoardingCubit/state.dart';
import '../Shop/cubit/cubit.dart';
import '../../shared/remote/SharedPreferences/CacheHelper.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingShopAppCubit, OnboardingShopAppState>(
      builder: ((context, state) {
        var CubitOnBoarding = OnboardingShopAppCubit.get(context);
        PageController BoardingPageController = PageController();
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: AppBar(
                  title: TextButton(
                      onPressed: () {
                        gotoLoginPage(context: context);
                      },
                      child: Text(
                        "تخطي",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  actions: [
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).ChangeAppMode();
                      },
                      icon: Icon(Icons.dark_mode),
                    ),
                  ]),
              body: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                          onPageChanged: (index) {
                            if (index == ItemModel.length - 1) {
                              CubitOnBoarding.LastPageOnBoarding = true;
                            } else {
                              CubitOnBoarding.LastPageOnBoarding = false;
                            }
                          },
                          physics: ScrollPhysics(),
                          controller: BoardingPageController,
                          itemCount: ItemModel.length,
                          itemBuilder: ((context, index) =>
                              BuildItemOnBoarding(ItemModel[index]))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SmoothPageIndicator(
                            effect: ExpandingDotsEffect(),
                            controller: BoardingPageController,
                            count: ItemModel.length),
                        Spacer(),
                        FloatingActionButton(
                            child: Text("التالي"),
                            onPressed: () {
                              if (CubitOnBoarding.LastPageOnBoarding) {
                                gotoLoginPage(context: context);
                              } else {
                                BoardingPageController.nextPage(
                                  duration: Duration(milliseconds: 750),
                                  curve: Curves.decelerate,
                                );
                              }
                            })
                      ],
                    ),
                  ],
                ),
              )),
        );
      }),
      listener: ((context, state) {}),
    );
  }
}
