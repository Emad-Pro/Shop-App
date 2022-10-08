import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../components/components.dart';
import '../../../../cubit/layoutCubit/cubit.dart';
import '../../../../cubit/layoutCubit/states.dart';
import '../../ShopLayout.dart';

class ProductDetils extends StatelessWidget {
  ProductDetils({Key? key, this.id}) : super(key: key);
  final int? id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ShopCubit>(context)
        ..GetProductDetils(itemprodcut: id),
      child: BlocConsumer<ShopCubit, Shopstates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  title: state is ShopLoadingGetProductDetilsState ||
                          ShopCubit.get(context).getProductDetilsModel == null
                      ? Container()
                      : Text(
                          "${ShopCubit.get(context).getProductDetilsModel!.data!.name!}"),
                ),
                body: state is ShopLoadingGetProductDetilsState ||
                        ShopCubit.get(context).getProductDetilsModel == null
                    ? Center(child: CircularProgressIndicator())
                    : Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Image(
                                          image: NetworkImage(
                                            ShopCubit.get(context)
                                                .getProductDetilsModel!
                                                .data!
                                                .image!,
                                          ),
                                          height: 200,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        color: FlexColor.redWineDarkPrimary,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 200,
                                              child: Text(
                                                ShopCubit.get(context)
                                                    .getProductDetilsModel!
                                                    .data!
                                                    .name!,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              "${ShopCubit.get(context).getProductDetilsModel!.data!.price}ج.م",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 300,
                                        child: Swiper(
                                          indicatorLayout:
                                              PageIndicatorLayout.SCALE,
                                          autoplay: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Image(
                                                image: NetworkImage(
                                                    ShopCubit.get(context)
                                                        .getProductDetilsModel!
                                                        .data!
                                                        .images![index]));
                                          },
                                          itemCount: ShopCubit.get(context)
                                              .getProductDetilsModel!
                                              .data!
                                              .images!
                                              .length,
                                          pagination: SwiperPagination(
                                              builder: SwiperPagination.dots),
                                          control: SwiperControl(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          padding: EdgeInsets.all(10),
                                          width: double.infinity,
                                          child: Text("تفاصيل المنتج"),
                                          color: FlexColor.redWineDarkPrimary),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      ShopCubit.get(context).seemore
                                          ? Text(
                                              ShopCubit.get(context)
                                                  .getProductDetilsModel!
                                                  .data!
                                                  .description!,
                                            )
                                          : Text(
                                              ShopCubit.get(context)
                                                  .getProductDetilsModel!
                                                  .data!
                                                  .description!,
                                              maxLines: 4,
                                            ),
                                      TextButton(
                                          onPressed: () {
                                            ShopCubit.get(context)
                                                .changeitemcaros();
                                          },
                                          child: ShopCubit.get(context).seemore
                                              ? Text("عرض اقل")
                                              : Text("عرض المزيد")),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    MaterialButton(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      minWidth: 200,
                                      elevation: 0,
                                      color: ShopCubit.get(context).cart![id]!
                                          ? FlexColor.redWineDarkPrimary
                                          : Colors.white,
                                      onPressed: () {
                                        ShopCubit.get(context)
                                            .AddRemoveCart(id);
                                      },
                                      child: ShopCubit.get(context).cart![id]!
                                          ? Text("حذف من السلة")
                                          : Text("اضافة للسلة"),
                                    ),
                                    Spacer(),
                                    MaterialButton(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 15),
                                        onPressed: () {
                                          ShopCubit.get(context)
                                              .changeFAVORITES(id);
                                        },
                                        child: Icon(
                                          Icons.favorite,
                                          color:
                                              ShopCubit.get(context).favo![id]!
                                                  ? FlexColor.redWineDarkPrimary
                                                  : Colors.white,
                                        ))
                                  ],
                                ))
                          ],
                        )));
          }),
    );
  }
}
