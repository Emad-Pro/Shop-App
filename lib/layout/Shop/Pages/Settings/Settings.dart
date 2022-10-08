import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/components/components.dart';
import 'package:my_app_shop/cubit/LoginCubit/cubit.dart';
import 'package:my_app_shop/cubit/LoginCubit/states.dart';

import 'package:widget_circular_animator/widget_circular_animator.dart';

import '../../../../cubit/layoutCubit/cubit.dart';
import '../../../../cubit/layoutCubit/states.dart';
import '../../../../shared/remote/SharedPreferences/CacheHelper.dart';
import '../../../login/LoginScreen.dart';
import '../Profile/Profile.dart';
import '../address/address.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..GetProfileData(),
      child: BlocConsumer<ShopCubit, Shopstates>(
        listener: (context, state) {},
        builder: (context, state) {
          TextEditingController? name = TextEditingController();
          TextEditingController? email = TextEditingController();
          TextEditingController? phone = TextEditingController();
          var formkey = GlobalKey<FormState>();
          if (ShopCubit.get(context).profileData == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            name.text =
                ShopCubit.get(context).profileData!.data!.name.toString();
            email.text =
                ShopCubit.get(context).profileData!.data!.email.toString();
            phone.text =
                ShopCubit.get(context).profileData!.data!.phone.toString();
            return SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Center(
                          child: WidgetCircularAnimator(
                            size: 200,
                            innerIconsSize: 3,
                            outerIconsSize: 3,
                            innerAnimation: Curves.easeInOutBack,
                            outerAnimation: Curves.easeInOutBack,
                            innerColor: Color.fromARGB(255, 181, 172, 196),
                            outerColor: Color.fromARGB(255, 211, 165, 106),
                            innerAnimationSeconds: 10,
                            outerAnimationSeconds: 10,
                            child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[200]),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      ShopCubit.get(context)
                                          .profileData!
                                          .data!
                                          .image
                                          .toString()),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormFiledDefult(
                            readonly: true,
                            prefixicon: Icon(Icons.account_circle),
                            HintText: "الاسم",
                            ispassword: false,
                            FormFielController: name,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "الرجاء ادخال الاسم";
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormFiledDefult(
                            readonly: true,
                            prefixicon: Icon(Icons.alternate_email_outlined),
                            HintText: "البريد الالكتروني",
                            ispassword: false,
                            FormFielController: email,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "الرجاء ادخال البريد الالكتروني";
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormFiledDefult(
                            readonly: true,
                            prefixicon: Icon(Icons.phone),
                            HintText: "رقم الهاتف",
                            ispassword: false,
                            FormFielController: phone,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "الرجاء ادخال رقم الهاتف";
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: BtnClick(
                                    textbtn: "تعديل البيانات",
                                    clickbtn: () {
                                      BtnPushClick(
                                          context,
                                          Profile(name.text, email.text,
                                              phone.text));
                                    }

                                    //  NavigateToCantBack(context, LoginScreen());
                                    ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: BtnClick(
                                    textbtn: "عناويني",
                                    clickbtn: () {
                                      BtnPushClick(context, Address());
                                    }),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        BtnClick(
                            textbtn: "تسجيل خروج",
                            clickbtn: () {
                              CacheHelper.clearData(key: "token").then((value) {
                                NavigateToCantBack(context, LoginScreen());
                              });
                              token = '';
                            }),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
