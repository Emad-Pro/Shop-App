import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../cubit/layoutCubit/cubit.dart';
import '../layout/Shop/Pages/Cateogries/CategoriesItem.dart';
import '../layout/Shop/Pages/Products/productDetils.dart';

import '../layout/login/LoginScreen.dart';
import '../model/Catigores_model.dart';
import '../model/Home_model.dart';
import '../shared/remote/SharedPreferences/CacheHelper.dart';

/* Boarding Page */
class BoardingModel {
  String? boardingTitle;
  String? boardingBody;
  String? BoardingImage;
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
  bool? readonly,
}) =>
    Container(
      padding: paddingcontainer,
      child: TextFormField(
        readOnly: readonly ?? false,
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

/**Home Page */
Widget? buildDiscountItem(model, context, state, {int? indexDetils}) =>
    GestureDetector(
      onTap: () {
        NavigateTo(
            context,
            ProductDetils(
              id: model.id,
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Image(
                    width: 200,
                    height: 200,
                    image: NetworkImage(model.image.toString()),
                  ),
                  if (model.discount != 0)
                    Banner(
                        message: "خصم حتي ${model.discount}",
                        location: BannerLocation.topStart),
                ],
              ),
              Text(
                "${model.name!}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 7.0,
                  ),
                  if (model.discount != 0)
                    Text(
                      "${model.oldPrice.round()}",
                      style: TextStyle(decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: ShopCubit.get(context).cart![model.id]!
                        ? Colors.cyan[900]
                        : Colors.white,
                    child: IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          ShopCubit.get(context).AddRemoveCart(model.id);
                        },
                        icon: Icon(Icons.shopping_cart)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: ShopCubit.get(context).favo![model.id]!
                        ? Colors.cyan[900]
                        : Colors.white,
                    child: IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          ShopCubit.get(context).changeFAVORITES(model.id);
                        },
                        icon: Icon(Icons.favorite_border_rounded)),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
/**Home Page */

/**Product Page */
Widget ProductBuilder(
        HomeModel model, CatigoresModel catigoresModel, context, state) =>
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model.data!.Banners!.map((e) {
                return Image(
                  image: NetworkImage("${e.image.toString()}"),
                  width: double.infinity,
                );
              }).toList(),
              options: CarouselOptions(
                  initialPage: 0,
                  height: 250,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1,
                  reverse: false)),
          SizedBox(
            height: 30,
          ),
          Text(
            "الفئات",
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          Container(
            height: 120,
            child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount:
                    ShopCubit.get(context).catigoresModel!.data!.data!.length,
                separatorBuilder: (context, index) => SizedBox(
                      width: 12,
                    ),
                itemBuilder: (context, index) => BuildCategories(
                    ShopCubit.get(context).catigoresModel!.data!.data![index],
                    context)),
          ),
          Text(
            "منتجات جديدة",
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          Container(
            child: GridView.count(
                addSemanticIndexes: true,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1 / 1.6,
                children: List.generate(
                    model.data!.Products!.length,
                    (index) => BuidGridProduct(
                        model.data!.Products![index], context, state,
                        indexDetils: index))),
          )
        ],
      ),
    );

Widget BuidGridProduct(model, context, state, {int? indexDetils}) =>
    GestureDetector(
      onTap: () {
        NavigateTo(
            context,
            ProductDetils(
              id: model.id,
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Center(
                child: Image(
                  width: 200,
                  height: 200,
                  image: NetworkImage(model.image.toString()),
                ),
              ),
              if (model.discount != 0)
                Banner(
                    message: "خصم حتي ${model.discount}",
                    location: BannerLocation.topStart),
            ],
          ),
          Text(
            "${model.name!}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Text(
                '${model.price.round()}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 7.0,
              ),
              if (model.discount != 0)
                Text(
                  "${model.oldPrice.round()}",
                  style: TextStyle(decoration: TextDecoration.lineThrough),
                ),
              Spacer(),
              CircleAvatar(
                backgroundColor: ShopCubit.get(context).cart![model.id]!
                    ? Colors.cyan[900]
                    : Colors.white,
                child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      ShopCubit.get(context).AddRemoveCart(model.id);
                    },
                    icon: Icon(Icons.shopping_cart)),
              ),
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundColor: ShopCubit.get(context).favo![model.id]!
                    ? Colors.cyan[900]
                    : Colors.white,
                child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      ShopCubit.get(context).changeFAVORITES(model.id);
                    },
                    icon: Icon(Icons.favorite_border_rounded)),
              )
            ],
          )
        ],
      ),
    );
Widget BuildCategories(DataModel model, context) => GestureDetector(
      onTap: () {
        NavigateTo(
            context,
            CategoriesItem(
              id: model.id,
              title: model.name,
            ));
      },
      child: Container(
        height: 110,
        width: 100,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            Container(
                height: 20,
                width: 200,
                color: FlexColor.redWineDarkPrimary,
                child: Text(
                  '${model.name}',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ))
          ],
        ),
      ),
    );
/**Product Page */

/**Favorets Page */
Widget BuildFavItem(model, context, index) => GestureDetector(
      onTap: () {
        NavigateTo(
            context,
            ProductDetils(
              id: model.id,
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: FlexColor.redWineDarkPrimary),
        child: Row(children: [
          Stack(children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 25,
              backgroundImage: NetworkImage(scale: 2, '${model.image}'),
            ),
            if (model.discount != 0)
              Banner(
                  message: 'خصم حتي ${model.discount} %',
                  location: BannerLocation.topStart),
          ]),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 250,
                  child: Text(
                    "${model.name!}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                model.price != model.oldPrice
                    ? Row(
                        children: [
                          Text("السعر :${model.price}"),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${model.oldPrice}",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough),
                          )
                        ],
                      )
                    : Text(" السعر :${model.price}"),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
          Column(
            children: [
              CircleAvatar(
                backgroundColor: FlexColor.redWineDarkPrimary,
                child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      ShopCubit.get(context).changeFAVORITES(model.id);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: ShopCubit.get(context).favo![model.id]!
                          ? Colors.white
                          : Colors.black,
                    )),
              ),
              CircleAvatar(
                backgroundColor: FlexColor.redWineDarkPrimary,
                child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      ShopCubit.get(context).AddRemoveCart(model.id);
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      color: ShopCubit.get(context).cart![model.id]!
                          ? Colors.white
                          : Colors.black,
                    )),
              ),
            ],
          )
        ]),
      ),
    );
/**Favorets Page */
/**Categries Page */
Widget BuildCategoriesPage(DataModel model, context) => GestureDetector(
      onTap: () {
        NavigateTo(
            context,
            CategoriesItem(
              id: model.id,
              title: model.name,
            ));
      },
      child: Row(
        children: [
          Image(width: 90, height: 90, image: NetworkImage('${model.image}')),
          SizedBox(
            width: 20,
          ),
          Text(
            "${model.name}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
      /**Categries Page */