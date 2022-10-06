import 'package:flutter/material.dart';
import 'package:my_app_shop/components/components.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

class ForgotPasswortScreen extends StatelessWidget {
  const ForgotPasswortScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("نسيت كلمة المرور"),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: EdgeInsetsDirectional.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageScreen(
                    ImagePath: "lib/assets/images/Login/Untitled-1.png",
                    FlexExpanded: 4),
                TitleBodyPage(context, TextTitle: "نسيت كلمة المرور ؟"),
                Container(
                  margin: EdgeInsetsDirectional.all(10),
                  child: Text(
                      "لا تقلق! يحدث ذلك. الرجاء إدخال العنوان المرتبط بحسابك"),
                ),
                TextFormFiledDefult(
                    ispassword: false,
                    paddingcontainer: EdgeInsets.symmetric(vertical: 20),
                    prefixicon: Icon(Icons.alternate_email),
                    HintText: "البريد الالكتروني"),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  height: 45,
                  minWidth: double.infinity,
                  onPressed: () {},
                  child: Text("ارسال"),
                  color: FlexColor.redWineDarkPrimary,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
