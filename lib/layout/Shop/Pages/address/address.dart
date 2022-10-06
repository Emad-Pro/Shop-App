import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/components/components.dart';
import 'package:my_app_shop/layout/Shop/cubit/cubit.dart';
import 'package:my_app_shop/layout/Shop/cubit/states.dart';

import 'AddAddress.dart';
import 'UpdateAddress.dart';

class Address extends StatelessWidget {
  Address({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopCubit()..getAddressData(),
        child: BlocConsumer<ShopCubit, Shopstates>(listener: (context, state) {
          if (state is ShopSuccessAddAddress) {
            ShopCubit()..getAddressData();
          }
          if (state is ShopSuccessDeleteAddress) {
            StyledToastTest(
                ShopCubit.get(context).deleteAdressModel!.message.toString(),
                context,
                ColorTostStates.success);
          }
        }, builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: ShopCubit.get(context).getAddressModel == null
                ? Center(child: CircularProgressIndicator())
                : Directionality(
                    textDirection: TextDirection.rtl,
                    child: ConditionalBuilder(
                      condition: ShopCubit.get(context)
                              .getAddressModel!
                              .data!
                              .dataAdress!
                              .length !=
                          0,
                      fallback: (context) => Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("لا يوجد عناوين حتي الان"),
                            ButtonAddNewAddress(context)
                          ],
                        ),
                      ),
                      builder: ((context) {
                        return Column(
                          children: [
                            Expanded(
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      separatorBuilder: (context, index) {
                                        return Divider();
                                      },
                                      itemCount: ShopCubit.get(context)
                                          .getAddressModel!
                                          .data!
                                          .dataAdress!
                                          .length,
                                      itemBuilder: (context, index) =>
                                          BuildListAddress(
                                              ShopCubit.get(context)
                                                  .getAddressModel!
                                                  .data!
                                                  .dataAdress![index],
                                              context,
                                              index))),
                            ),
                            ButtonAddNewAddress(context)
                          ],
                        );
                      }),
                    ),
                  ),
          );
        }));
  }

  Widget BuildListAddress(model, context, index) => Container(
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
                    Text(" الاسم :${model.name}"),
                    Text(" المدينة :${model.city}"),
                    Text(" المنطقة :${model.region}"),
                    Text(" التفاصيل :${model.details}"),
                    Text(" ملاحظات :${model.notes}"),
                    Text(" خط الطول :${model.latitude}"),
                    Text(" خط العرض :${model.longitude}")
                  ],
                ),
              ),
              Spacer(),
              Container(
                width: 60,
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          BtnPushClick(
                              context,
                              UpdateAddress(
                                id: index,
                                id_product: model.id,
                              ));
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          ShopCubit.get(context).DeleteAddressData(model.id);
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
              )
            ],
          ),
        ),
      );
  Widget ButtonAddNewAddress(context) => Container(
        margin: EdgeInsets.all(10),
        height: 50,
        child: MaterialButton(
          color: FlexColor.redWineDarkPrimary,
          onPressed: () {
            BtnPushClick(context, Addaddress());
          },
          child: Text(
            "إضافة عنوان جديد",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
}
