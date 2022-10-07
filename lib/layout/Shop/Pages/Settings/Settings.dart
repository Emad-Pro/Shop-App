import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/components/components.dart';
import 'package:my_app_shop/cubit/LoginCubit/cubit.dart';
import 'package:my_app_shop/cubit/LoginCubit/states.dart';
import 'package:my_app_shop/layout/Shop/cubit/cubit.dart';
import 'package:my_app_shop/layout/Shop/cubit/states.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

import '../../../../shared/remote/SharedPreferences/CacheHelper.dart';
import '../../../login/LoginScreen.dart';
import '../address/address.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginState>(
      listener: (context, state) {
        /*  if (state is ShopLoginSuccessState) {
          ShopLoginCubit()..getProfileData();
        }*/
      },
      builder: (context, state) {
        TextEditingController? name = TextEditingController();
        TextEditingController? email = TextEditingController();
        TextEditingController? phone = TextEditingController();
        var formkey = GlobalKey<FormState>();
        if (ShopLoginCubit.get(context).LoginModel == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          name.text =
              ShopLoginCubit.get(context).LoginModel!.data!.name.toString();
          email.text =
              ShopLoginCubit.get(context).LoginModel!.data!.email.toString();
          phone.text =
              ShopLoginCubit.get(context).LoginModel!.data!.phone.toString();
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
                                    ShopLoginCubit.get(context)
                                        .LoginModel!
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
                      /* BtnClick(
                            textbtn: "تحديث",
                            clickbtn: () {
                              if (formkey.currentState!.validate()) {
                                ShopLoginCubit.get(context).UpdateUserData(
                                    email: email!.text,
                                    name: name!.text,
                                    phone: phone!.text);
                                StyledToastTest("تم تحديث البيانات بنجاح",
                                    context, ColorTostStates.success);
                              }
    
                              //  NavigateToCantBack(context, LoginScreen());
                            }),*/
                      SizedBox(
                        height: 15,
                      ),
                      BtnClick(
                          textbtn: "تسجيل خروج",
                          clickbtn: () {
                            ShopCubit.get(context).currentIndex = 0;
                            CacheHelper.clearData(key: "token").then((value) {
                              NavigateToCantBack(context, LoginScreen());
                            });
                            token = '';
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      BtnClick(
                          textbtn: "عناويني",
                          clickbtn: () {
                            BtnPushClick(context, Address());
                          })
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
