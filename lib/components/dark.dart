import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart' show Color, Colors;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../cubit/layoutCubit/cubit.dart';
import '../cubit/layoutCubit/states.dart';

class colorsNewApp {
  Color white = Colors.white;
  Color black = Colors.black;
  Color gray = HexColor('7F8487');
  Color blackhex = HexColor('121212');
}

colorsNewApp colorUse = colorsNewApp();
Widget DarkLightMod(context, startwidget) =>
    BlocConsumer<ShopCubit, Shopstates>(
      listener: (context, state) {},
      builder: (context, state) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: FlexThemeData.light(
                scheme: FlexScheme.redWine,
                fontFamily: 'El_Messiri',
                appBarBackground: FlexColor.redWineDarkPrimary,
                swapColors: true),
            darkTheme: FlexThemeData.dark(
                appBarBackground: FlexColor.redWineDarkPrimary,
                scaffoldBackground: HexColor("#272427"),
                fontFamily: 'El_Messiri',
                scheme: FlexScheme.redWine,
                darkIsTrueBlack: false,
                swapColors: true),

            /*    theme: ThemeData(
  
        inputDecorationTheme: InputDecorationTheme(
  
            enabledBorder:
  
                OutlineInputBorder(borderSide: BorderSide(color: colorUse.gray)),
  
            iconColor: colorUse.gray,
  
            border: OutlineInputBorder(
  
                borderSide: BorderSide(color: colorUse.gray),
  
                borderRadius: BorderRadius.all(Radius.circular(10))),
  
            labelStyle: TextStyle(color: colorUse.gray)),
  
        textTheme: TextTheme(
  
            bodyText2: TextStyle(
  
              fontFamily: 'ElMessiri',
  
              color: colorUse.black,
  
              fontSize: 15,
  
            ),
  
            bodyText1: TextStyle(
  
                fontFamily: 'ElMessiri',
  
                color: colorUse.black,
  
                fontSize: 18,
  
                fontWeight: FontWeight.w600)),
  
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
  
            enableFeedback: true,
  
            elevation: 100,
  
            showUnselectedLabels: false,
  
            showSelectedLabels: true,
  
            type: BottomNavigationBarType.fixed,
  
            selectedItemColor: colorUse.black),
  
        appBarTheme: AppBarTheme(
  
            iconTheme: IconThemeData(color: colorUse.black),
  
            color: colorUse.white,
  
            elevation: 0,
  
            titleTextStyle: TextStyle(
  
                color: colorUse.black, fontSize: 20, fontWeight: FontWeight.bold),
  
            systemOverlayStyle:
  
                SystemUiOverlayStyle(statusBarColor: colorUse.black)),
  
      ),
  
      darkTheme: ThemeData(
  
        fontFamily: "El_Messiri",
  
        backgroundColor: Colors.blue,
  
        iconTheme: IconThemeData(color: colorUse.white),
  
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.black),
  
        inputDecorationTheme: InputDecorationTheme(
  
            focusedBorder:
  
                OutlineInputBorder(borderSide: BorderSide(color: colorUse.white)),
  
            enabledBorder:
  
                OutlineInputBorder(borderSide: BorderSide(color: colorUse.white)),
  
            iconColor: colorUse.white,
  
            hintStyle: TextStyle(color: Colors.white),
  
            suffixIconColor: Colors.white,
  
            border: OutlineInputBorder(
  
                borderSide: BorderSide(color: colorUse.white),
  
                borderRadius: BorderRadius.all(Radius.circular(10))),
  
            prefixStyle: TextStyle(color: colorUse.white),
  
            labelStyle: TextStyle(color: colorUse.white)),
  
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.grey[900]),
  
        scrollbarTheme: ScrollbarThemeData(
  
          thumbColor: MaterialStateProperty.all(colorUse.black),
  
        ),
  
        textTheme: TextTheme(
  
            bodyText2: TextStyle(
  
              color: colorUse.white,
  
              fontFamily: 'El_Messiri',
  
              fontSize: 15,
  
            ),
  
            bodyText1: TextStyle(
  
                color: colorUse.white,
  
                fontFamily: 'El_Messiri',
  
                fontSize: 18,
  
                fontWeight: FontWeight.w600)),
  
        appBarTheme: AppBarTheme(
  
            iconTheme: IconThemeData(color: colorUse.white),
  
            color: colorUse.blackhex,
  
            elevation: 0,
  
            titleTextStyle: TextStyle(
  
                color: colorUse.white, fontSize: 20, fontWeight: FontWeight.bold),
  
            systemOverlayStyle:
  
                SystemUiOverlayStyle(statusBarColor: colorUse.black)),
  
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
  
            unselectedItemColor: colorUse.white,
  
            backgroundColor: colorUse.blackhex,
  
            enableFeedback: true,
  
            elevation: 100,
  
            showUnselectedLabels: false,
  
            showSelectedLabels: true,
  
            type: BottomNavigationBarType.fixed,
  
            selectedItemColor: colorUse.white),
  
        scaffoldBackgroundColor: colorUse.blackhex,
  
      ),*/

            themeMode: ShopCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: startwidget!);
      },
    );
