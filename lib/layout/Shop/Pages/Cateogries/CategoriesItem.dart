import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/components.dart';
import '../../../../cubit/layoutCubit/cubit.dart';
import '../../../../cubit/layoutCubit/states.dart';
import '../Products/Products.dart';
import '../Products/productDetils.dart';

class CategoriesItem extends StatelessWidget {
  const CategoriesItem({Key? key, this.id, this.title}) : super(key: key);
  final int? id;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()
        ..getCategoriesItem(ItemModel: id!)
        ..getHomeData(),
      child: BlocConsumer<ShopCubit, Shopstates>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(title!),
                actions: [],
              ),
              body: ShopCubit.get(context).homeModel == null ||
                      ShopCubit.get(context).getCategoriesItemModel == null
                  ? Center(child: CircularProgressIndicator())
                  : Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: GridView.count(
                            crossAxisCount: 2,
                            addSemanticIndexes: true,
                            shrinkWrap: false,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1 / 1.6,
                            children: List.generate(
                              ShopCubit.get(context)
                                  .getCategoriesItemModel!
                                  .data!
                                  .product!
                                  .length,
                              (index) => BuidGridCategories(
                                  ShopCubit.get(context)
                                      .getCategoriesItemModel!
                                      .data!
                                      .product![index],
                                  context,
                                  state,
                                  indexDetils: index),
                            )),
                      ),
                    ),
            );
          },
          listener: (context, state) {}),
    );
  }
}

Widget BuidGridCategories(model, context, state, {int? indexDetils}) =>
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
            overflow: TextOverflow.fade,
          ),
          Row(
            children: [
              Text(
                '${model.oldPrice.round()}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 7.0,
              ),
              if (model.oldPrice != model.oldPrice)
                if (model.oldPrice != 0)
                  Text(
                    "${model.price.round()}",
                    style: TextStyle(
                        fontSize: 12, decoration: TextDecoration.lineThrough),
                  ),
              Spacer(),
              /*   CircleAvatar(
                backgroundColor: ShopCubit.get(context).cart![model.id]!
                    ? Colors.purple[900]
                    : Colors.white,
                child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      ShopCubit.get(context).AddRemoveCart(model.id);
                    },
                    icon: Icon(Icons.shopping_cart)),
              ),*/
              SizedBox(
                width: 10,
              ),
              /* CircleAvatar(
                backgroundColor: ShopCubit.get(context).favo![model.id]!
                    ? Colors.purple[900]
                    : Colors.white,
                child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      ShopCubit.get(context).changeFAVORITES(model.id);
                    },
                    icon: Icon(Icons.favorite_border_rounded)),
              )*/
            ],
          )
        ],
      ),
    );
