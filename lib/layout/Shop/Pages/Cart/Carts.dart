import 'package:emoji_alert/arrays.dart';
import 'package:emoji_alert/emoji_icon.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:my_app_shop/layout/Shop/Pages/Cart/purchase.dart';
import 'package:my_app_shop/layout/Shop/cubit/cubit.dart';
import 'package:my_app_shop/layout/Shop/cubit/states.dart';

import '../../../../components/components.dart';
import '../Products/Products.dart';
import '../Products/productDetils.dart';

class Carts extends StatelessWidget {
  const Carts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getCartItem(),
      child: BlocConsumer<ShopCubit, Shopstates>(listener: (context, state) {
        if (state is ShopSuccessUpdateCartItemDataState) {
          StyledToastTest(
              ShopCubit.get(context).updateItemCart!.message!.toString(),
              context,
              ColorTostStates.success);
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("السلة"),
          ),
          body: ShopCubit.get(context).getCartItemModel == null
              ? Center(child: CircularProgressIndicator())
              : ShopCubit.get(context)
                      .getCartItemModel!
                      .data!
                      .cartItems!
                      .isEmpty
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EmojiIcon(emojiType: EMOJI_TYPE.ANGRY),
                        Text("السلة فاضية اخلص اشتري حاجه"),
                      ],
                    ))
                  : Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: GridView.count(
                                addSemanticIndexes: true,
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 1 / 1.6,
                                children: List.generate(
                                  ShopCubit.get(context)
                                      .getCartItemModel!
                                      .data!
                                      .cartItems!
                                      .length,
                                  (index) => BuidGridCartItem(
                                      ShopCubit.get(context)
                                          .getCartItemModel!
                                          .data!
                                          .cartItems![index]
                                          .product,
                                      context,
                                      state,
                                      index),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "اجمالي المدفوع : ${ShopCubit.get(context).getCartItemModel!.data!.total} ج.م",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        "اجمالي السلع : ${ShopCubit.get(context).getCartItemModel!.data!.cartItems!.length}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                Spacer(),
                                MaterialButton(
                                  color: FlexColor.redDarkPrimary,
                                  elevation: 0,
                                  minWidth: 200,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  onPressed: () {
                                    BtnPushClick(context, Purchase());
                                  },
                                  child: Text(
                                    "اكمال الشراء",
                                    style: TextStyle(),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
        );
      }),
    );
  }

  Widget BuidGridCartItem(model, context, state, int index) => GestureDetector(
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
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
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
                  ' السعر :${model.price.round()}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 7.0,
                ),
                if (model.oldPrice != 0)
                  Text(
                    "${model.oldPrice.round()}",
                    style: TextStyle(
                        fontSize: 12, decoration: TextDecoration.lineThrough),
                  ),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: InputQty(
                maxVal: 99,
                initVal: 1,
                steps: 1,
                minVal: 1,
                onQtyChanged: (val) {
                  ShopCubit.get(context).UpdateItemCart(
                    ProductId: val!.toInt(),
                    IdProductCart: ShopCubit.get(context)
                        .getCartItemModel!
                        .data!
                        .cartItems![index]
                        .id,
                  );
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              child: MaterialButton(
                color: FlexColor.redWineDarkPrimary,
                onPressed: () {
                  ShopCubit.get(context).AddRemoveCart(model.id);
                },
                child: Text("حذف من السة"),
              ),
            )
          ],
        ),
      );
}
