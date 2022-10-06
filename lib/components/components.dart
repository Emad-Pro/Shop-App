import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:my_app_shop/layout/Shop/cubit/cubit.dart';

import '../layout/login/LoginScreen.dart';
import '../shared/remote/SharedPreferences/CacheHelper.dart';

/* Boarding Page */
class BoardingModel {
  String boardingTitle;
  String boardingBody;
  String BoardingImage;
  BoardingModel(
      {required this.boardingTitle,
      required this.boardingBody,
      required this.BoardingImage});
}

List<BoardingModel> ItemModel = [
  BoardingModel(
      boardingTitle: "سرعة توصيل",
      boardingBody: "سرعة في ايصال المنتج الي العميل ",
      BoardingImage: 'lib/assets/images/onBording/First.png'),
  BoardingModel(
    boardingTitle: "خصومات وطرق دفع مختلفة",
    boardingBody:
        "يمكنك الحصول علي خصومات تصل الي 70% علي المنتجات وايضاً الدفع كاش او فيزا",
    BoardingImage: 'lib/assets/images/onBording/Second.png',
  ),
  BoardingModel(
      boardingTitle: "المنتجات",
      boardingBody: "توافر الالف من المنتجات ولن تحتاج الي البحث في اماكن اخري",
      BoardingImage: 'lib/assets/images/onBording/Third.png')
];
Widget BuildItemOnBoarding(BoardingModel ItemBoardingModel) => Column(
      children: [
        //PageView.builder(itemBuilder: ((context, index) => ))
        Expanded(
          child: Image(
            image: AssetImage('${ItemBoardingModel.BoardingImage}'),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '${ItemBoardingModel.boardingTitle}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '${ItemBoardingModel.boardingBody}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
void NavigateTo(
  context,
  Widget,
) =>
    Navigator.push(context, MaterialPageRoute(builder: (contex) => Widget));
void NavigateToCantBack(context, Widget) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (contex) => Widget), (route) {
      return false;
    });
void gotoLoginPage({context}) {
  CacheHelper.saveData(
    key: 'onBoarding',
    value: true,
  ).then((value) {
    NavigateToCantBack(
      context,
      LoginScreen(),
    );
  });
}
/* Boarding Page */

/* Login & register & resetPassword & otp Page */
Widget ImageScreen({required String ImagePath, required int FlexExpanded}) =>
    Center(
      child: Image.asset(
        ImagePath,
        scale: 4.0,
      ),
    );
Widget TitleBodyPage(context, {required String TextTitle}) => Container(
      margin: EdgeInsetsDirectional.all(10),
      child: Text(
        TextTitle,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.headline5?.fontSize,
        ),
      ),
    );
Widget TextFormFiledDefult({
  required Icon prefixicon,
  required String HintText,
  MaterialButton? suffixIcon,
  TextInputType? typekeyboard,
  TextEditingController? FormFielController,
  String? Function(String?)? validate,
  EdgeInsetsGeometry? paddingcontainer,
  required bool ispassword,
}) =>
    Container(
      padding: paddingcontainer,
      child: TextFormField(
        keyboardType: typekeyboard,
        controller: FormFielController,
        validator: validate,
        obscureText: ispassword,
        // style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            prefixIcon: prefixicon, hintText: HintText, suffixIcon: suffixIcon),
      ),
    );
Widget BtnClick({required String textbtn, VoidCallback? clickbtn}) =>
    MaterialButton(
      padding: EdgeInsets.all(15),
      color: FlexColor.redWineDarkPrimary,
      minWidth: double.infinity,
      child: Text(
        textbtn,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      onPressed: clickbtn,
    );
void BtnPushClick(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (contex) => Widget));

ToastFuture StyledToastTest(String msg, context, ColorTostStates? state) =>
    showToast(msg,
        backgroundColor: ChocseTosteColor(state!),
        context: context,
        animation: StyledToastAnimation.slideFromTopFade,
        reverseAnimation: StyledToastAnimation.slideToTopFade,
        position:
            StyledToastPosition(align: Alignment.bottomCenter, offset: 3.0),
        startOffset: Offset(0.0, -3.0),
        reverseEndOffset: Offset(0.0, 3.0),
        duration: Duration(seconds: 4),
        //Animation duration   animDuration * 2 <= duration
        animDuration: Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.fastOutSlowIn);

enum ColorTostStates {
  success,
  erorr,
  warninig,
}

String? token;
Color? ChocseTosteColor(ColorTostStates state) {
  Color? color;
  switch (state) {
    case ColorTostStates.success:
      color = Colors.green;
      break;
    case ColorTostStates.erorr:
      color = Colors.red;
      break;
    case ColorTostStates.warninig:
      color = Colors.orange;
      break;
  }
  return color;
}
/* Login & register & resetPassword & otp Page */
