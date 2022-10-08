import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/components.dart';
import '../../../../cubit/layoutCubit/cubit.dart';
import '../../../../cubit/layoutCubit/states.dart';

class Cateogries extends StatelessWidget {
  const Cateogries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getCatigoresData(),
      child: BlocConsumer<ShopCubit, Shopstates>(
        listener: (context, state) {},
        builder: (context, state) => ConditionalBuilder(
            condition: ShopCubit.get(context).catigoresModel != null,
            fallback: (context) => Center(child: CircularProgressIndicator()),
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: BuildCategoriesPage(
                            ShopCubit.get(context)
                                .catigoresModel!
                                .data!
                                .data![index],
                            context),
                      ),
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                itemCount:
                    ShopCubit.get(context).catigoresModel!.data!.data!.length)),
      ),
    );
  }
}
