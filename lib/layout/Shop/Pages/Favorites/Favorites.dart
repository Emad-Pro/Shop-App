import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:emoji_alert/arrays.dart';
import 'package:emoji_alert/emoji_icon.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_app_shop/model/FavoritesPage_model.dart';

import '../../../../components/components.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../Products/productDetils.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()
        ..getFavoritsData()
        ..getHomeData(),
      child: BlocConsumer<ShopCubit, Shopstates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: ConditionalBuilder(
                condition: ShopCubit.get(context).favoritsModel != null &&
                    ShopCubit.get(context).homeModel != null,
                builder: ((context) {
                  return ConditionalBuilder(
                      condition: ShopCubit.get(context)
                          .favoritsModel!
                          .data!
                          .dataProduct!
                          .isNotEmpty,
                      fallback: (context) => Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              EmojiIcon(emojiType: EMOJI_TYPE.ANGRY),
                              SizedBox(
                                height: 15,
                              ),
                              Text(" ايه يابطل مفيش حاجه عجباك"),
                            ],
                          )),
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return BuildFavItem(
                                    ShopCubit.get(context)
                                        .favoritsModel!
                                        .data!
                                        .dataProduct![index]
                                        .product,
                                    context,
                                    index);
                              },
                              separatorBuilder: (context, index) {
                                return Container(
                                  height: 5,
                                );
                              },
                              itemCount: ShopCubit.get(context)
                                  .favoritsModel!
                                  .data!
                                  .dataProduct!
                                  .length),
                        );
                      });
                }),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }),
    );
  }

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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
}
