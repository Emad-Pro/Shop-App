import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:emoji_alert/arrays.dart';
import 'package:emoji_alert/emoji_icon.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/components.dart';
import '../../../../cubit/layoutCubit/cubit.dart';
import '../../../../cubit/layoutCubit/states.dart';

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
}
