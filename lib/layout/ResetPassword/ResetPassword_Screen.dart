import 'package:flutter/material.dart';
import 'package:my_app_shop/components/components.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    FlexExpanded: 2),
                TitleBodyPage(context, TextTitle: "استعادة كلمة المرور"),
                TextFormFiledDefult(
                    ispassword: false,
                    paddingcontainer: EdgeInsets.symmetric(vertical: 10),
                    prefixicon: Icon(Icons.lock_outline_rounded),
                    HintText: "كتابة كلمة المرور الجديدة"),
                TextFormFiledDefult(
                    ispassword: false,
                    paddingcontainer: EdgeInsets.symmetric(vertical: 10),
                    prefixicon: Icon(Icons.lock_outline_rounded),
                    HintText: "اعد كتابة كلمة المرور الجديدة"),
                BtnClick(textbtn: "تعيين")
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
