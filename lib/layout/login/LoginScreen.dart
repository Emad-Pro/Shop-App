import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:my_app_shop/layout/forgotPassword/ForgotPasswort_Screen.dart';
import 'package:my_app_shop/layout/Shop/ShopLayout.dart';
import 'package:my_app_shop/layout/Shop/cubit/cubit.dart';
import 'package:my_app_shop/layout/Shop/cubit/states.dart';
import 'package:my_app_shop/shared/remote/SharedPreferences/CacheHelper.dart';

import '../register/RegisterScreen.dart';
import '../../components/components.dart';
import '../../cubit/LoginCubit/cubit.dart';
import '../../cubit/LoginCubit/states.dart';
import '../../model/login_model.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginState>(
      listener: (context, state) {
        if (state is ShopLoginSuccessState) {
          if (state.LoginModel!.Status!.toString() == "true") {
            CacheHelper.saveData(
                    key: "token", value: state.LoginModel!.data!.token)
                .then((value) {
              token = state.LoginModel!.data!.token;
              NavigateToCantBack(context, ShopLayout());
            });
          } else {
            StyledToastTest(state.LoginModel!.Message.toString(), context,
                ColorTostStates.erorr);
          }
        }
      },
      builder: (context, state) {
        var formkey = GlobalKey<FormState>();

        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  ShopCubit.get(context).ChangeAppMode();
                },
                icon: Icon(Icons.brightness_2_rounded),
              ),
            ],
          ),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              margin: EdgeInsetsDirectional.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageScreen(
                          ImagePath: "lib/assets/images/Login/Untitled-1.png",
                          FlexExpanded: 2),
                      TitleBodyPage(context, TextTitle: "تسجيل الدخول"),
                      TextFormFiledDefult(
                        paddingcontainer: EdgeInsets.symmetric(vertical: 10),
                        ispassword: false,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "أدخل البريد الالكتروني";
                          }
                          return null;
                        },
                        FormFielController: EmailController,
                        HintText: "البريد الالكتروني",
                        prefixicon: Icon(Icons.alternate_email_outlined),
                        typekeyboard: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormFiledDefult(
                          ispassword:
                              ShopLoginCubit.get(context).PasswordVisibility,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "أدخل كلمة المرور";
                            }
                            return null;
                          },
                          FormFielController: PasswordController,
                          prefixicon: Icon(Icons.lock_outline_rounded),
                          HintText: "كلمة المرور",
                          suffixIcon: MaterialButton(
                            minWidth: 0,
                            height: 0,
                            focusElevation: 10,
                            onPressed: () {
                              ShopLoginCubit.get(context).ispassword();
                            },
                            child: Icon(
                              ShopLoginCubit.get(context).suffixicon,
                            ),
                          ),
                          typekeyboard: TextInputType.text),
                      SizedBox(
                        height: 15,
                      ),
                      TextButton(
                        onPressed: () {
                          BtnPushClick(context, ForgotPasswortScreen());
                        },
                        child: Text(
                          "نسيت كلمة المرور?",
                          style: TextStyle(),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                        builder: (context) => BtnClick(
                            textbtn: "دخول",
                            clickbtn: () async {
                              token = '';
                              if (formkey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: EmailController.text,
                                  password: PasswordController.text,
                                );
                              }
                            }),
                        fallback: ((context) =>
                            Center(child: CircularProgressIndicator())),
                        condition: state is! ShopLoginLoadingState,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: Center(
                            child: Text(
                              "او ",
                              textAlign: TextAlign.center,
                            ),
                          )),
                      MaterialButton(
                        elevation: 0,
                        color: Color.fromARGB(255, 241, 245, 246),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Row(
                              children: [
                                Image.asset(
                                  "lib/assets/images/Login/google.png",
                                  scale: 1.1,
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Text("الدخول بأستخدام جوجل "),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("مستخدم جديد ؟"),
                          TextButton(
                              onPressed: () {
                                BtnPushClick(context, RegisterScreen());
                              },
                              child: Text("أنشاء حساب"))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
