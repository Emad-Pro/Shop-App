import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/cubit/RegisterCubit/cubit.dart';
import 'package:my_app_shop/cubit/RegisterCubit/states.dart';
import 'package:my_app_shop/layout/login/LoginScreen.dart';
import 'package:my_app_shop/components/components.dart';
import 'package:my_app_shop/shared/remote/SharedPreferences/CacheHelper.dart';

import '../Shop/ShopLayout.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  TextEditingController NameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
      listener: ((context, state) {
        if (state is ShopRegisterSuccessState) {
          if (state.RegisterModel!.Status!.toString() == "true") {
            CacheHelper.saveData(
                    key: "token", value: state.RegisterModel!.data!.token)
                .then((value) {
              token = state.RegisterModel!.data!.token;
              NavigateToCantBack(context, LoginScreen());
              StyledToastTest(state.RegisterModel!.Message.toString(), context,
                  ColorTostStates.success);
            });
          } else {
            StyledToastTest(state.RegisterModel!.Message.toString(), context,
                ColorTostStates.erorr);
          }
        }
      }),
      builder: (context, state) {
        var formkey = GlobalKey<FormState>();
        return Scaffold(
          appBar: AppBar(),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              margin: EdgeInsetsDirectional.all(20),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 200,
                          width: 200,
                          child: ImageScreen(
                              FlexExpanded: 2,
                              ImagePath: "lib/assets/images/register/reg.png"),
                        ),
                      ),
                      TitleBodyPage(context, TextTitle: "أنشاء حساب"),
                      TextFormFiledDefult(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "أدخل الاسم ";
                            }
                            return null;
                          },
                          FormFielController: NameController,
                          ispassword: false,
                          prefixicon: Icon(Icons.perm_identity),
                          HintText: "الاسم بالكامل"),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormFiledDefult(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "أدخل البريد الالكتروني ";
                            }
                            return null;
                          },
                          FormFielController: EmailController,
                          ispassword: false,
                          prefixicon: Icon(Icons.alternate_email_outlined),
                          HintText: "البريد الالكتروني"),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormFiledDefult(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "أدخل كلمة السر ";
                            }
                            return null;
                          },
                          FormFielController: PhoneController,
                          ispassword: false,
                          prefixicon: Icon(Icons.phone),
                          HintText: "رقم الهاتف"),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormFiledDefult(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "أدخل رقم الهاتف ";
                            }
                            return null;
                          },
                          FormFielController: PasswordController,
                          ispassword:
                              ShopRegisterCubit.get(context).PasswordVisibility,
                          prefixicon: Icon(Icons.lock_outline_rounded),
                          suffixIcon: MaterialButton(
                            minWidth: 0,
                            height: 0,
                            focusElevation: 10,
                            onPressed: () {
                              ShopRegisterCubit.get(context).ispassword();
                            },
                            child:
                                Icon(ShopRegisterCubit.get(context).suffixicon),
                          ),
                          HintText: "كلمة المرور"),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(maxLines: 1, "بالتسجيل ، أنت توافق على"),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              maxLines: 1,
                              "سياسة الخصوصية والشروط",
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                        builder: (context) => BtnClick(
                            textbtn: "تسجيل",
                            clickbtn: () async {
                              if (formkey.currentState!.validate()) {
                                ShopRegisterCubit.get(context)
                                    .InterNetConniction();
                                if (ShopRegisterCubit.get(context)
                                    .isConnected!) {
                                  ShopRegisterCubit.get(context).userRegister(
                                      name: NameController.text,
                                      email: EmailController.text,
                                      password: PasswordController.text,
                                      phone: PhoneController.text);
                                } else {
                                  StyledToastTest(
                                      "تأكد من اتصال الانترنت واعد المحاولة",
                                      context,
                                      ColorTostStates.warninig);
                                }
                              }
                            }),
                        fallback: ((context) =>
                            Center(child: CircularProgressIndicator())),
                        condition: state is! ShopRegisterLoadingState,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(" لديك حساب بالفعل ؟"),
                          TextButton(
                              onPressed: () {
                                NavigateToCantBack(context, LoginScreen());
                              },
                              child: Text("تسجيل الدخول"))
                        ],
                      )
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
