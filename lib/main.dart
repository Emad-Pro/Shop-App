import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:my_app_shop/cubit/RegisterCubit/cubit.dart';

import 'package:my_app_shop/layout/Shop/ShopLayout.dart';
import 'package:my_app_shop/shared/blocObserver.dart';
import 'package:my_app_shop/shared/remote/SharedPreferences/CacheHelper.dart';
import 'package:my_app_shop/shared/remote/dioHelper/dio_helper.dart';

import 'components/components.dart';
import 'components/dark.dart';
import 'cubit/LoginCubit/cubit.dart';
import 'cubit/onBoardingCubit/cubit.dart';
import 'layout/Shop/Pages/Search/cubit/cubit.dart';
import 'layout/Shop/cubit/cubit.dart';
import 'layout/login/LoginScreen.dart';

import 'layout/OnBoarding/onBoarding.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  bool? onBoarding = CacheHelper.GetSaveData(key: 'onBoarding');
  /* اصلاح مشكلة شهادات عرض البيانات من الانترتن */
  HttpOverrides.global = new MyHttpOverrides();
  /* اصلاح مشكلة شهادات عرض البيانات من الانترتن */
  token = CacheHelper.GetSaveData(key: 'token');
  DioHelper.init();
  Widget widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoarding();
  }
  print(onBoarding);
  bool? isDark = CacheHelper.GetSaveData(key: 'isDark');
  runApp(Main(startwidget: widget, isDark ?? false));
}

class Main extends StatelessWidget {
  final bool isDark;
  Main(this.isDark, {this.startwidget});
  final Widget? startwidget;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: MultiBlocProvider(providers: [
        BlocProvider(create: (context) => OnboardingShopAppCubit()),
        BlocProvider(
            create: (context) => ShopLoginCubit()
              ..InterNetConniction()
              ..getProfileData()),
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..GetProductDetils()
              ..getCatigoresData()
              ..getFavoritsData()
              ..getCartItem()
              ..getAddressData()
              ..GetOrderData()
              ..ChangeAppMode(fromShared: isDark)),
        BlocProvider(create: (context) => ShopRegisterCubit()),
        BlocProvider(create: (contex) => SearchCubit()..SearchProduct())
      ], child: DarkLightMod(context, startwidget)),
    );
  }
}

/* اصلاح مشكلة شهادات عرض البيانات من الانترتن */
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
/* اصلاح مشكلة شهادات عرض البيانات من الانترتن */
