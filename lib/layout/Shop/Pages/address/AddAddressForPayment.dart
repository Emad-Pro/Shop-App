import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/components/components.dart';
import 'package:my_app_shop/cubit/LoginCubit/cubit.dart';
import 'package:my_app_shop/layout/Shop/Pages/address/address.dart';

import '../../../../cubit/layoutCubit/cubit.dart';
import '../../../../cubit/layoutCubit/states.dart';
import '../Cart/purchase.dart';

class Addaddresspayment extends StatelessWidget {
  Addaddresspayment({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (context) => ShopCubit()..getAddressData(),
          child:
              BlocConsumer<ShopCubit, Shopstates>(listener: (context, state) {
            if (state is ShopSuccessAddAddress) {
              StyledToastTest('${ShopCubit.get(context).addAdress!.message}',
                  context, ColorTostStates.success);
              nameController.clear();
              cityController.clear();
              regionController.clear();
              detailsController.clear();
              notesController.clear();
              latitudeController.clear();
              longitudeController.clear();
              BtnPushClick(context, Purchase());
            } else if (state is ShopErorrAddAddress) {
              StyledToastTest('تعذرت الاضافة', context, ColorTostStates.erorr);
            }
          }, builder: (context, state) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Form(
                key: formkey,
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "إضافة عنوان جديد",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "الرجاء ادخال الاسم";
                            }
                            return null;
                          },
                          controller: nameController,
                          decoration: InputDecoration(hintText: "الاسم"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "الرجاء ادخال المدينة";
                            }
                            return null;
                          },
                          controller: cityController,
                          decoration: InputDecoration(hintText: "المدينة"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "الرجاء ادخال المنطقة";
                            }
                            return null;
                          },
                          controller: regionController,
                          decoration: InputDecoration(hintText: "المنطقة"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "الرجاء ادخال تفاصيل العنوان";
                            }
                            return null;
                          },
                          controller: detailsController,
                          decoration: InputDecoration(hintText: "تفاصيل"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "الرجاء ادخال ملاحظات";
                            }
                            return null;
                          },
                          controller: notesController,
                          decoration: InputDecoration(hintText: "ملحوظات"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "الرجاء ادخال خط الطول";
                            }
                            return null;
                          },
                          controller: latitudeController,
                          decoration: InputDecoration(hintText: "خط الطول"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "الرجاء ادخال خط العرض";
                            }
                            return null;
                          },
                          controller: longitudeController,
                          decoration: InputDecoration(hintText: "خط العرض"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BtnClick(
                            textbtn: "اضافة العنوان",
                            clickbtn: () {
                              if (formkey.currentState!.validate()) {
                                ShopCubit.get(context).addAddress(
                                    name: nameController.text,
                                    city: cityController.text,
                                    region: regionController.text,
                                    details: detailsController.text,
                                    notes: notesController.text,
                                    latitude: latitudeController.text,
                                    longitude: longitudeController.text);
                              }
                            }),
                        Text(
                            "ملاحظات\n في حالة عدم وجود تفاصيل او ملحوظات قم بكتابة : لايوجد\n في عدم معرفتك لخطوط العرض او الطول يمكنك كتابت 0 في كلتا الحقلين")
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
