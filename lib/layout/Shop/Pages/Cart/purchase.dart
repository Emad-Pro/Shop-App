import 'package:emoji_alert/arrays.dart';
import 'package:emoji_alert/emoji_icon.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/components/components.dart';
import 'package:my_app_shop/layout/Shop/Pages/Cart/DonePurchese.dart';

import '../../../../cubit/layoutCubit/cubit.dart';
import '../../../../cubit/layoutCubit/states.dart';

import '../address/AddAddressForPayment.dart';

class Purchase extends StatelessWidget {
  Purchase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => ShopCubit()..getAddressData()),
      child: BlocConsumer<ShopCubit, Shopstates>(
        listener: (context, state) {},
        builder: (context, state) {
          return BlocConsumer<ShopCubit, Shopstates>(
            listener: ((context, state) {
              if (state is ShopSuccessOrderAdd) {
                ShopCubit.get(context).GetOrderData();
              }
            }),
            builder: ((context, state) {
              return Scaffold(
                body: ShopCubit.get(context).getAddressModel == null
                    ? Center(child: CircularProgressIndicator())
                    : Directionality(
                        textDirection: TextDirection.rtl,
                        child: ShopCubit.get(context)
                                .getAddressModel!
                                .data!
                                .dataAdress!
                                .isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    EmojiIcon(emojiType: EMOJI_TYPE.COOL),
                                    Text("ضيف عنوانك يابيه"),
                                    MaterialButton(
                                      color: FlexColor.redDarkPrimary,
                                      onPressed: () {
                                        BtnPushClick(
                                            context, Addaddresspayment());
                                      },
                                      child: Text(
                                        "إضافة عنوان",
                                        style: TextStyle(),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.all(15),
                                child: ListView.separated(
                                    itemBuilder: ((context, index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: BuildItemAddress(
                                            ShopCubit.get(context)
                                                .getAddressModel!
                                                .data!
                                                .dataAdress![index],
                                            context,
                                            index),
                                      );
                                    }),
                                    separatorBuilder: (context, index) =>
                                        Divider(),
                                    itemCount: ShopCubit.get(context)
                                        .getAddressModel!
                                        .data!
                                        .dataAdress!
                                        .length),
                              ),
                      ),
                appBar: AppBar(
                  title: Text("اختيار العنوان"),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

Widget BuildItemAddress(model, context, index) => Container(
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
                  Text(
                    " الاسم :${model.name}",
                    style: TextStyle(color: FlexColor.darkBackground),
                  ),
                  Text(" المدينة :${model.city}",
                      style: TextStyle(color: FlexColor.darkBackground)),
                  Text(" المنطقة :${model.region}",
                      style: TextStyle(color: FlexColor.darkBackground)),
                ],
              ),
            ),
            Container(
              child: MaterialButton(
                color: FlexColor.darkBackground,
                onPressed: () {
                  BtnPushClick(
                      context,
                      DonePurchese(
                        idAddress: model.id,
                        nameAddress: model.name,
                        cityName: model.city,
                        regonName: model.region,
                        Detils: model.details,
                        Notes: model.notes,
                        latitude: model.latitude,
                        longitude: model.longitude,
                      ));
                },
                child: Text("اختر",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            )
          ],
        ),
      ),
    );
