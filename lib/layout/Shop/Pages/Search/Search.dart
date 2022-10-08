import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/layout/Shop/Pages/Search/cubit/cubit.dart';
import 'package:my_app_shop/layout/Shop/Pages/Search/cubit/state.dart';

import 'package:my_app_shop/model/FavoritesPage_model.dart';

import '../../../../cubit/layoutCubit/cubit.dart';
import '../../../../cubit/layoutCubit/states.dart';
import '../Favorites/Favorites.dart';
import 'cubit/cubit.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "البحث",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: FlexColor.redWineDarkPrimary),
                    ),
                  ),
                  onFieldSubmitted: (String? value) {
                    SearchCubit.get(context).SearchProduct(text: value);
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                if (state is SearchSuccessStates)
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return BuildSearchItem(
                              SearchCubit.get(context)
                                  .searchModel!
                                  .data!
                                  .data![index],
                              context,
                              index,
                              ShopCubit.get(context)
                                  .homeModel!
                                  .data!
                                  .Products![index]);
                        },
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 10,
                          );
                        },
                        itemCount: SearchCubit.get(context)
                                .searchModel!
                                .data!
                                .data!
                                .length -
                            1),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget BuildSearchItem(model, context, index, Productmodel) =>
      BlocConsumer<ShopCubit, Shopstates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: FlexColor.redWineDarkPrimary,
                ),
                child: Row(children: [
                  Stack(children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      width: 100,
                      height: 100,
                      child: Image(image: NetworkImage('${model.image}')),
                    ),
                    Productmodel!.discount != 0
                        ? Banner(
                            message: ' خصم حتي  ${Productmodel.discount} %',
                            location: BannerLocation.topStart)
                        : Container(),
                  ]),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            "${model.name!}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15),
                          ),
                        ),
                        Productmodel.price != Productmodel.oldPrice
                            ? Row(
                                children: [
                                  Text("${Productmodel.price}"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${Productmodel.oldPrice}",
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough),
                                  )
                                ],
                              )
                            : Text("${Productmodel.price}"),
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
                      )
                    ],
                  )
                ]),
              ),
            );
          });
}
