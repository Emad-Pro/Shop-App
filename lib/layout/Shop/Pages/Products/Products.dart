import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/layout/Shop/Pages/Products/productDetils.dart';
import 'package:my_app_shop/layout/Shop/cubit/cubit.dart';
import 'package:my_app_shop/layout/Shop/cubit/states.dart';
import 'package:my_app_shop/model/Catigores_model.dart';
import 'package:my_app_shop/model/Home_model.dart';

import '../../../../components/components.dart';
import '../Cateogries/CategoriesItem.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, Shopstates>(
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
        listener: ((context, state) {}));
  }

  Widget ProductBuilder(
          HomeModel model, CatigoresModel catigoresModel, context, state) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model.data!.Banners!.map((e) {
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
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 1,
                    reverse: false)),
            SizedBox(
              height: 30,
            ),
            Text(
              "الفئات",
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            Container(
              height: 120,
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount:
                      ShopCubit.get(context).catigoresModel!.data!.data!.length,
                  separatorBuilder: (context, index) => SizedBox(
                        width: 12,
                      ),
                  itemBuilder: (context, index) => BuildCategories(
                      ShopCubit.get(context).catigoresModel!.data!.data![index],
                      context)),
            ),
            Text(
              "منتجات جديدة",
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            Container(
              child: GridView.count(
                  addSemanticIndexes: true,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1 / 1.6,
                  children: List.generate(
                      model.data!.Products!.length,
                      (index) => BuidGridProduct(
                          model.data!.Products![index], context, state,
                          indexDetils: index))),
            )
          ],
        ),
      );
}

Widget BuidGridProduct(model, context, state, {int? indexDetils}) =>
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
      ),
    );
Widget BuildCategories(DataModel model, context) => GestureDetector(
      onTap: () {
        NavigateTo(
            context,
            CategoriesItem(
              id: model.id,
              title: model.name,
            ));
      },
      child: Container(
        height: 110,
        width: 100,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            Container(
                height: 20,
                width: 200,
                color: FlexColor.redWineDarkPrimary,
                child: Text(
                  '${model.name}',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ))
          ],
        ),
      ),
    );
