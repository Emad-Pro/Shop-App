import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/layout/Shop/Pages/Cateogries/CategoriesItem.dart';
import 'package:my_app_shop/layout/Shop/cubit/cubit.dart';
import 'package:my_app_shop/layout/Shop/cubit/states.dart';
import 'package:my_app_shop/model/Catigores_model.dart';

import '../../../../components/components.dart';
import '../Products/productDetils.dart';

class Cateogries extends StatelessWidget {
  const Cateogries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, Shopstates>(
      listener: (context, state) {},
      builder: (context, state) => ListView.separated(
          itemBuilder: (context, index) => Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: BuildCategoriesPage(
                      ShopCubit.get(context).catigoresModel!.data!.data![index],
                      context),
                ),
              ),
          separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
          itemCount: ShopCubit.get(context).catigoresModel!.data!.data!.length),
    );
  }

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
}
