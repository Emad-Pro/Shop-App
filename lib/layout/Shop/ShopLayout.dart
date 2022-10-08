import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/cubit/LoginCubit/cubit.dart';
import 'package:my_app_shop/cubit/LoginCubit/states.dart';

import 'package:my_app_shop/layout/login/LoginScreen.dart';
import 'package:my_app_shop/shared/remote/SharedPreferences/CacheHelper.dart';

import '../../components/components.dart';
import '../../cubit/layoutCubit/cubit.dart';
import '../../cubit/layoutCubit/states.dart';
import '../../model/GetCartItem.dart';
import '../../model/login_model.dart';
import 'Pages/Cart/Carts.dart';
import 'Pages/Orders/getOrder.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ShopLoginCubit, ShopLoginState>(
          listener: (context, state) {
            if (state is ShopLoginSuccessState) {
              ShopCubit()..GetProfileData();
            }
          },
        ),
      ],
      child: BlocConsumer<ShopCubit, Shopstates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                BtnPushClick(context, Carts());
              },
              child: Icon(Icons.shopping_bag_rounded),
            ),
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      BtnPushClick(context, getOrders());
                    },
                    icon: Icon(
                      Icons.delivery_dining,
                    )),
                IconButton(
                  onPressed: () {
                    ShopCubit.get(context).ChangeAppMode();
                  },
                  icon: Icon(Icons.dark_mode),
                ),
              ],
              title: Text(
                "Shop EA",
              ),
            ),
            body: ShopCubit.get(context)
                .bottomScreen[ShopCubit.get(context).currentIndex],
            bottomNavigationBar: CurvedNavigationBar(
              color: FlexColor.redWineDarkPrimary,
              backgroundColor:
                  ShopCubit.get(context).isDark ? Colors.black : Colors.white,
              height: 45,
              items: [
                Icon(
                  Icons.home_filled,
                  color: ShopCubit.get(context).isDark
                      ? Colors.black
                      : Colors.white,
                ),
                Icon(
                  Icons.shopping_bag,
                  color: ShopCubit.get(context).isDark
                      ? Colors.black
                      : Colors.white,
                ),
                Icon(
                  Icons.favorite,
                  color: ShopCubit.get(context).isDark
                      ? Colors.black
                      : Colors.white,
                ),
                Icon(
                  Icons.category_outlined,
                  color: ShopCubit.get(context).isDark
                      ? Colors.black
                      : Colors.white,
                ),
                Icon(
                  Icons.search,
                  color: ShopCubit.get(context).isDark
                      ? Colors.black
                      : Colors.white,
                ),
                Icon(
                  Icons.settings,
                  color: ShopCubit.get(context).isDark
                      ? Colors.black
                      : Colors.white,
                ),
              ],
              onTap: (index) {
                ShopCubit.get(context).changeBottomScreen(index);
              },
            ),
          );
        },
      ),
    );
  }
}

Widget TitleBottomSheet() => Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      width: double.infinity,
      child: Text(
        "المنتجات",
        style: TextStyle(fontSize: 25),
      ),
    );
Widget BuildAddOrder(context) => Container(
    width: double.infinity,
    color: Colors.grey[200],
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    child: Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "السلة",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.purple[900]),
            ),
            Text(
              "اجمالي المبلغ : ${ShopCubit.get(context).getCartItemModel!.data!.total}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color.fromARGB(255, 21, 90, 146)),
            ),
            Text(
              "عدد المنتجات : ${ShopCubit.get(context).getCartItemModel!.data!.cartItems!.length}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color.fromARGB(255, 21, 90, 146)),
            ),
          ],
        ),
        Spacer(),
        ElevatedButton(onPressed: () {}, child: Text('طلب اوردر'))
      ],
    ));
Widget BuildItemCart(Model, {index}) => Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        children: [
          Text("${Model.cartItems![index].product!.name}"),
          Image(
              height: 200,
              width: double.infinity,
              image: NetworkImage("${Model.cartItems![index].product!.image}")),
          Text("${Model.cartItems![index].product!.description}"),
          Container(
            color: Colors.grey[200],
            child: Row(
              children: [
                Text(" السعر :${Model.cartItems![index].product!.price}",
                    style: TextStyle(
                        color: Colors.purple[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                SizedBox(
                  width: 10,
                ),
                Model.cartItems![index].product!.oldPrice !=
                        Model.cartItems![index].product!.price
                    ? Text(
                        "${Model.cartItems![index].product!.oldPrice}",
                        style:
                            TextStyle(decoration: TextDecoration.lineThrough),
                      )
                    : Text('')
              ],
            ),
          )
        ],
      ),
    );
/*ElevatedButton(
              child: Text("Signout"),
              onPressed: () {
                CacheHelper.clearData(key: "token").then((value) {
                  NavigateToCantBack(context, LoginScreen());
                });
              },
            ),*/