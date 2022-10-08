import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/layout/Shop/Pages/Products/productDetils.dart';

import 'package:my_app_shop/model/Catigores_model.dart';
import 'package:my_app_shop/model/Home_model.dart';

import '../../../../components/components.dart';
import '../../../../cubit/layoutCubit/cubit.dart';
import '../../../../cubit/layoutCubit/states.dart';
import '../Cateogries/CategoriesItem.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()
        ..getHomeData()
        ..getCatigoresData(),
      child: BlocConsumer<ShopCubit, Shopstates>(
          builder: (context, state) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ConditionalBuilder(
                  condition: ShopCubit.get(context).homeModel != null &&
                      ShopCubit.get(context).catigoresModel != null,
                  fallback: (context) {
                    return Center(child: CircularProgressIndicator());
                  },
                  builder: (context) {
                    return ProductBuilder(ShopCubit.get(context).homeModel!,
                        ShopCubit.get(context).catigoresModel!, context, state);
                  },
                ),
              ),
            );
          },
          listener: ((context, state) {})),
    );
  }
}
