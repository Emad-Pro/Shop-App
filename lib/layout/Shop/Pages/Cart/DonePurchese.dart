import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/layout/Shop/Pages/Orders/getOrder.dart';
import 'package:my_app_shop/layout/Shop/Pages/Orders/getOrderDetils.dart';
import 'package:my_app_shop/layout/Shop/cubit/cubit.dart';
import 'package:my_app_shop/layout/Shop/cubit/states.dart';

import '../../../../components/components.dart';

class DonePurchese extends StatelessWidget {
  final dynamic idAddress;
  final String? nameAddress;
  final String? cityName;
  final String? regonName;
  final String? Detils;
  final String? Notes;
  final dynamic latitude;
  final dynamic longitude;
  DonePurchese(
      {this.idAddress,
      this.nameAddress,
      this.cityName,
      this.regonName,
      this.Detils,
      this.Notes,
      this.latitude,
      this.longitude});

  List<String> items = ["كاش", "فيزا"];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getCartItem(),
      child: BlocConsumer<ShopCubit, Shopstates>(
        listener: (context, state) {
          if (state is ShopSuccessOrderAdd) {
            NavigateToCantBack(context, getOrders());
            ShopCubit.get(context).GetOrderData();
            StyledToastTest(
                ShopCubit.get(context).addOrderModel!.message.toString(),
                context,
                ColorTostStates.success);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("تفاصيل عملية الشراء"),
            ),
            body: ShopCubit.get(context).getCartItemModel == null
                ? Center(child: CircularProgressIndicator())
                : Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "تفاصيل العنوان",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text("اسم العنوان : ${nameAddress}"),
                            Text("المدينة : ${cityName}"),
                            Text("المنطقة : ${regonName}"),
                            Text("التفاصيل : ${Detils}"),
                            Text("ملحوظات : ${Notes}"),
                            Text("خط الطول : ${latitude}"),
                            Text("خط العرض : ${longitude}"),
                            Container(
                              child: Text(
                                "اختيار طريقة الدفع",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomRadioButton(
                              elevation: 0,
                              absoluteZeroSpacing: false,
                              unSelectedColor: FlexColor.darkBackground,
                              buttonLables: items,
                              buttonValues: items,
                              defaultSelected: items[0],
                              buttonTextStyle: ButtonTextStyle(
                                  selectedColor: Colors.white,
                                  unSelectedColor: Colors.white,
                                  textStyle: TextStyle(fontSize: 16)),
                              radioButtonValue: (value) {
                                ShopCubit.get(context).paymentvalue(value);
                              },
                              selectedColor: FlexColor.redWineDarkPrimary,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text(
                                "المنتجات",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                  child: ListView.separated(
                                      itemBuilder: ((context, index) {
                                        return ItemBuy(
                                            ShopCubit.get(context)
                                                .getCartItemModel!
                                                .data!
                                                .cartItems![index]
                                                .product,
                                            index);
                                      }),
                                      separatorBuilder: (context, index) {
                                        return Divider();
                                      },
                                      itemCount: ShopCubit.get(context)
                                          .getCartItemModel!
                                          .data!
                                          .cartItems!
                                          .length)),
                            ),
                            Container(
                              height: 100,
                              child: Center(
                                child: MaterialButton(
                                    minWidth: double.infinity,
                                    height: 40,
                                    color: FlexColor.redWineDarkPrimary,
                                    onPressed: () {
                                      ShopCubit.get(context).addOrder(
                                          addressid: idAddress!.toInt(),
                                          paymethod: ShopCubit.get(context)
                                              .selectPaymentValue);
                                    },
                                    child: Text(
                                      "اتمام الشراء",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            )
                          ]),
                    ),
                  ),
          );
        },
      ),
    );
  }
}

Widget ItemBuy(model, index) => Container(
    padding: EdgeInsets.all(10),
    decoration:
        BoxDecoration(border: Border.all(color: FlexColor.redWineDarkPrimary)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(width: 100, height: 100, image: NetworkImage(model.image)),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 250, child: Text(model.name)),
            Text("السعر: ${model.price.toString()}"),
          ],
        )
      ],
    ));
