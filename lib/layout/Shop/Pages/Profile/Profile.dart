import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_app_shop/layout/login/LoginScreen.dart';

import '../../../../components/components.dart';
import '../../../../cubit/layoutCubit/cubit.dart';
import '../../../../cubit/layoutCubit/states.dart';
import '../ChangePassword/ChangePassword.dart';

// ignore: must_be_immutable
class Profile extends StatelessWidget {
  String? name;
  String? email;
  String? phone;

  Profile(this.name, this.email, this.phone, {super.key});

  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, Shopstates>(
        listener: (context, state) {
          if (state is ShopSuccessProfileUpdate) {
            if (ShopCubit.get(context).updatePrfile!.status == false) {
              StyledToastTest('${ShopCubit.get(context).updatePrfile!.message}',
                  context, ColorTostStates.erorr);
            }
            if (ShopCubit.get(context).updatePrfile!.status == true) {
              StyledToastTest('${ShopCubit.get(context).updatePrfile!.message}',
                  context, ColorTostStates.success);
              NavigateToCantBack(context, LoginScreen());
            }
          }
        },
        builder: (context, state) {
          TextEditingController nameController = TextEditingController();
          TextEditingController emailController = TextEditingController();
          TextEditingController phoneController = TextEditingController();
          TextEditingController passwordController = TextEditingController();
          nameController.text = name!;
          emailController.text = email!;
          phoneController.text = phone!;
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Form(
                    key: formkey,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "تحديث البيانات ",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "الرجاء ادخال الاسم";
                                }
                                return null;
                              },
                              controller: nameController,
                              decoration:
                                  const InputDecoration(hintText: "الاسم"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "الرجاء ادخال البريد الالكتروني";
                                }
                                return null;
                              },
                              controller: emailController,
                              decoration: const InputDecoration(
                                  hintText: "البريد الالكتروني"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "الرجاء ادخال رقم الهاتف";
                                }
                                return null;
                              },
                              controller: phoneController,
                              decoration:
                                  const InputDecoration(hintText: "رقم الهاتف"),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            BtnClick(
                                textbtn: "تحديث ",
                                clickbtn: () {
                                  if (formkey.currentState!.validate()) {
                                    ShopCubit.get(context).UpdateProfileData(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text);
                                  }
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            BtnClick(
                                textbtn: "تغيير كلمة المرور",
                                clickbtn: () {
                                  BtnPushClick(context, ChangePassword());
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
