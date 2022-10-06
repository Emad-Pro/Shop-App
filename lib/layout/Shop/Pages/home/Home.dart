import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/layout/Shop/cubit/states.dart';

import '../../../../components/components.dart';
import '../../../../cubit/LoginCubit/cubit.dart';
import '../../../../shared/remote/SharedPreferences/CacheHelper.dart';
import '../../../login/LoginScreen.dart';
import '../../cubit/cubit.dart';
import '../Products/Products.dart';
import '../Products/productDetils.dart';

class ShopHome extends StatelessWidget {
  const ShopHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, Shopstates>(
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
                          height: 200,
                          child: CarouselSlider(
                              items: ShopCubit.get(context)
                                  .homeModel!
                                  .data!
                                  .Banners!
                                  .map((e) {
                                return Image(
                                  image: NetworkImage("${e.image.toString()}"),
                                  width: double.infinity,
                                );
                              }).toList(),
                              options: CarouselOptions(
                                  initialPage: 0,
                                  height: 250,
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
    );
  }
}

Widget? buildDiscountItem(model, context, state, {int? indexDetils}) =>
    GestureDetector(
      onTap: () {
        NavigateTo(
            context,
            ProductDetils(
              id: model.id,
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Image(
                    width: 200,
                    height: 200,
                    image: NetworkImage(model.image.toString()),
                  ),
                  if (model.discount != 0)
                    Banner(
                        message: "خصم حتي ${model.discount}",
                        location: BannerLocation.topStart),
                ],
              ),
              Text(
                "${model.name!}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 7.0,
                  ),
                  if (model.discount != 0)
                    Text(
                      "${model.oldPrice.round()}",
                      style: TextStyle(decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: ShopCubit.get(context).cart![model.id]!
                        ? Colors.cyan[900]
                        : Colors.white,
                    child: IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          ShopCubit.get(context).AddRemoveCart(model.id);
                        },
                        icon: Icon(Icons.shopping_cart)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: ShopCubit.get(context).favo![model.id]!
                        ? Colors.cyan[900]
                        : Colors.white,
                    child: IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          ShopCubit.get(context).changeFAVORITES(model.id);
                        },
                        icon: Icon(Icons.favorite_border_rounded)),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
