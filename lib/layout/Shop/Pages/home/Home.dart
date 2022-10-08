import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/components.dart';
import '../../../../cubit/LoginCubit/cubit.dart';
import '../../../../cubit/layoutCubit/cubit.dart';
import '../../../../cubit/layoutCubit/states.dart';
import '../../../../shared/remote/SharedPreferences/CacheHelper.dart';
import '../../../login/LoginScreen.dart';

import '../Products/Products.dart';
import '../Products/productDetils.dart';

class ShopHome extends StatelessWidget {
  const ShopHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getHomeData(),
      child: BlocConsumer<ShopCubit, Shopstates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ShopCubit.get(context).homeModel == null
              ? Center(child: CircularProgressIndicator())
              : Scaffold(
                  body: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 220,
                            child: CarouselSlider(
                                items: ShopCubit.get(context)
                                    .homeModel!
                                    .data!
                                    .Banners!
                                    .map((e) {
                                  return Image(
                                    image:
                                        NetworkImage("${e.image.toString()}"),
                                    width: double.infinity,
                                  );
                                }).toList(),
                                options: CarouselOptions(
                                    initialPage: 0,
                                    height: 200,
                                    enableInfiniteScroll: true,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        Duration(seconds: 3),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    scrollDirection: Axis.horizontal,
                                    viewportFraction: 1,
                                    reverse: false)),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: GridView.count(
                                  addSemanticIndexes: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1 / 1.6,
                                  children: List.generate(
                                      ShopCubit.get(context)
                                          .homeModel!
                                          .data!
                                          .Products!
                                          .length,
                                      (index) => BuidGridProduct(
                                          ShopCubit.get(context)
                                              .homeModel!
                                              .data!
                                              .Products![index],
                                          context,
                                          state,
                                          indexDetils: index))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
