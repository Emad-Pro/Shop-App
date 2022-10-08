import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/components/components.dart';

import '../../../../cubit/layoutCubit/cubit.dart';
import '../../../../cubit/layoutCubit/states.dart';
import '../../ShopLayout.dart';

class getOrdersDetils extends StatelessWidget {
  final int? id;

  const getOrdersDetils({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: ((context) => ShopCubit()..GetOrderDetils(idOrder: id)),
          child:
              BlocConsumer<ShopCubit, Shopstates>(listener: (context, state) {
            /* if (state is ShopSuccessDeleteAddress) {
                        StyledToastTest(
                ShopCubit.get(context).deleteAdressModel!.message.toString(),
                context,
                ColorTostStates.success);
                      }*/
          }, builder: (context, state) {
            return Directionality(
                textDirection: TextDirection.rtl,
                child: state is ShopLoadingOrderGetDetils ||
                        ShopCubit.get(context).getOrderDetilsModel == null
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: FlexColor.redWineDarkPrimary,
                                  borderRadius: BorderRadius.circular(15)),
                              height: 200,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            " تفاصيل الاوردر ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              " حالة المنتج :${ShopCubit.get(context).getOrderDetilsModel!.data!.status}"),
                                          Text(
                                              " التاريخ :${ShopCubit.get(context).getOrderDetilsModel!.data!.date}"),
                                          Text(
                                              " اجمالي المبلغ :${ShopCubit.get(context).getOrderDetilsModel!.data!.cost}"),
                                          Text(
                                              " طريقة الدفع :${ShopCubit.get(context).getOrderDetilsModel!.data!.paymentMethod}"),
                                          Text(
                                              " برومو كود :${ShopCubit.get(context).getOrderDetilsModel!.data!.promoCode}"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            " تفاصيل العنوان ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              " الاسم :${ShopCubit.get(context).getOrderDetilsModel!.data!.address!.name}"),
                                          Text(
                                              " المدينة :${ShopCubit.get(context).getOrderDetilsModel!.data!.address!.city}"),
                                          Text(
                                              " المنطقة :${ShopCubit.get(context).getOrderDetilsModel!.data!.address!.region}"),
                                          Text(
                                              " التفاصيل :${ShopCubit.get(context).getOrderDetilsModel!.data!.address!.details}"),
                                          Text(
                                              " الملحوظات :${ShopCubit.get(context).getOrderDetilsModel!.data!.address!.notes}"),
                                          Text(
                                              " خط الطول :${ShopCubit.get(context).getOrderDetilsModel!.data!.address!.latitude}"),
                                          Text(
                                              " خط العرض :${ShopCubit.get(context).getOrderDetilsModel!.data!.address!.longitude}"),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              " محتوي الاوردر ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) =>
                                      BuildListAddress(
                                          ShopCubit.get(context)
                                              .getOrderDetilsModel!
                                              .data!
                                              .products![index],
                                          context,
                                          index),
                                  separatorBuilder: (context, index) =>
                                      Divider(),
                                  itemCount: ShopCubit.get(context)
                                      .getOrderDetilsModel!
                                      .data!
                                      .products!
                                      .length),
                            )
                          ],
                        ),
                      ));
          }),
        ));
  }

  Widget BuildListAddress(model, context, index) => Container(
        height: 100,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: FlexColor.redWineDarkPrimary,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              child: Image(image: NetworkImage(model.image)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: 200,
                  child: Text(
                    model.name,
                    overflow: TextOverflow.clip,
                    softWrap: true,
                    maxLines: 1,
                  ),
                ),
                Text(" السعر :${model.price.toString()}")
              ],
            )
          ],
        ),
      );
}
