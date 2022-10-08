import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:emoji_alert/arrays.dart';
import 'package:emoji_alert/emoji_alert.dart';
import 'package:emoji_alert/emoji_icon.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/components/components.dart';

import '../../../../cubit/layoutCubit/cubit.dart';
import '../../../../cubit/layoutCubit/states.dart';
import '../../ShopLayout.dart';
import 'getOrderDetils.dart';

class getOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..GetOrderData(),
      child: BlocConsumer<ShopCubit, Shopstates>(listener: ((context, state) {
        if (state is ShopSuccessOrderCancel) {
          StyledToastTest(
              ShopCubit.get(context).cancelOrderModel!.message.toString(),
              context,
              ColorTostStates.success);
        }
        if (state is ShopSuccessOrderAdd) {
          ShopCubit.get(context).GetOrderData();
          StyledToastTest(
              ShopCubit.get(context).addOrderModel!.message.toString(),
              context,
              ColorTostStates.success);
        }
      }), builder: ((context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text("الطلبات"),
              actions: [
                IconButton(
                    onPressed: () {
                      NavigateToCantBack(context, ShopLayout());
                    },
                    icon: Icon(Icons.home))
              ],
            ),
            body: Directionality(
                textDirection: TextDirection.rtl,
                child: ShopCubit.get(context).getOrderModel == null
                    ? Center(child: CircularProgressIndicator())
                    : ShopCubit.get(context).getOrderModel!.data!.dataOrder ==
                            null
                        ? Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              EmojiIcon(emojiType: EMOJI_TYPE.SAD),
                              SizedBox(
                                height: 15,
                              ),
                              Text("لا يوجد طلبات حتي الان ")
                            ],
                          ))
                        : ConditionalBuilder(
                            condition: ShopCubit.get(context)
                                    .getOrderModel!
                                    .data!
                                    .dataOrder!
                                    .length !=
                                0,
                            fallback: (context) => Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("الطلبات فارغة"),
                                ],
                              ),
                            ),
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.separated(
                                        scrollDirection: Axis.vertical,
                                        separatorBuilder: (context, index) {
                                          return Divider();
                                        },
                                        itemCount: ShopCubit.get(context)
                                            .getOrderModel!
                                            .data!
                                            .dataOrder!
                                            .length,
                                        itemBuilder: (context, index) =>
                                            BuildListAddress(
                                                ShopCubit.get(context)
                                                    .getOrderModel!
                                                    .data!
                                                    .dataOrder![index],
                                                context,
                                                index),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )));
      })),
    );
  }
}

Widget BuildListAddress(model, context, index) => GestureDetector(
      onTap: () {
        BtnPushClick(
            context,
            getOrdersDetils(
              id: model.id,
            ));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: FlexColor.redWineDarkPrimary,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: SingleChildScrollView(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(" اجمالي المدفوع :${model.total.round()}"),
                    Text(" التاريخ :${model.date}"),
                    Text(" الحالة :${model.status}"),
                  ],
                ),
              ),
              Spacer(),
              Container(
                width: 100,
                child: Column(
                  children: [
                    if (ShopCubit.get(context)
                            .getOrderModel!
                            .data!
                            .dataOrder![index]
                            .status ==
                        'جديد')
                      MaterialButton(
                        onPressed: () {
                          EmojiAlert(
                              description: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(" هل تريد الغاء الاوردر؟"),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        ShopCubit.get(context).CancelOrder(
                                            idOrder: ShopCubit.get(context)
                                                .getOrderModel!
                                                .data!
                                                .dataOrder![index]
                                                .id);
                                        Navigator.pop(context);
                                      },
                                      child: Text("نعم")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("لا"))
                                ],
                              )
                            ],
                          )).displayAlert(context);
                        },
                        child: Text("الغاء الاوردر"),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
