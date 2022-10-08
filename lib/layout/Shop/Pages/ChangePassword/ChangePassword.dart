import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:my_app_shop/cubit/layoutCubit/cubit.dart';
import 'package:my_app_shop/cubit/layoutCubit/states.dart';
import 'package:my_app_shop/layout/login/LoginScreen.dart';

import '../../../../components/components.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, Shopstates>(
        listener: (context, state) {
          if (state is ShopSuccessChangePassword) {
            if (ShopCubit.get(context).Changepassword!.status == true) {
              StyledToastTest(
                  "${ShopCubit.get(context).Changepassword!.message}",
                  context,
                  ColorTostStates.success);
              NavigateToCantBack(context, LoginScreen());
            } else {
              StyledToastTest(
                  "${ShopCubit.get(context).Changepassword!.message}",
                  context,
                  ColorTostStates.erorr);
            }
          }
        },
        builder: (context, state) {
          TextEditingController PasswordCurrently = TextEditingController();
          TextEditingController NewPassword = TextEditingController();
          return Scaffold(
            appBar: AppBar(
              title: Text("تغيير كلمة المرور"),
            ),
            body: Directionality(
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
                              return "أدخل كلمة المرور الحالة";
                            }
                            return null;
                          },
                          controller: PasswordCurrently,
                          decoration: const InputDecoration(
                              hintText: "كلمة المرور الحالية"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "ادخل كلمة المرور الجديدة";
                            }
                            return null;
                          },
                          controller: NewPassword,
                          decoration: const InputDecoration(
                              hintText: "كلمة المرور الجديدة"),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        BtnClick(
                            textbtn: "تحديث ",
                            clickbtn: () {
                              if (formkey.currentState!.validate()) {
                                ShopCubit.get(context).ChangePasswrod(
                                    CurrentlyPassword: PasswordCurrently.text,
                                    NewPasswrod: NewPassword.text);
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
