// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/cubit/LoginCubit/states.dart';
import 'package:my_app_shop/layout/Shop/cubit/cubit.dart';

import 'package:my_app_shop/model/login_model.dart';
import 'package:my_app_shop/shared/remote/dioHelper/dio_helper.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

import '../../../shared/remote/endpoint.dart';
import '../../components/components.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  //internetconniction
  bool? isConnected;
  void InterNetConniction() async {
    emit(ShopLoginCheckInternet());
    isConnected = await SimpleConnectionChecker.isConnectedToInternet();
  }

  ShopLoginModel? LoginModel;
  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(ShopLoginLoadingState());
    await DioHelper.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((value) {
      LoginModel = ShopLoginModel.fromJson(value.data);
      ShopCubit()
        ..getHomeData()
        ..GetProductDetils()
        ..getCatigoresData()
        ..getFavoritsData()
        ..getCartItem()
        ..getAddressData()
        ..GetOrderData();
      emit(ShopLoginSuccessState(LoginModel));
    }).catchError((Erorr) {
      print(Erorr.toString());
      emit(ShopLoginErorrState(Erorr.toString()));
    });
  }

  bool PasswordVisibility = true;
  IconData suffixicon = Icons.visibility;
  Color? colorbisibility = Colors.white;
  void ispassword() {
    PasswordVisibility = !PasswordVisibility;
    if (PasswordVisibility == true) {
      suffixicon = Icons.visibility_off_rounded;
      colorbisibility = Colors.white;
    } else {
      suffixicon = Icons.visibility;
      colorbisibility = Colors.white;
    }

    emit(ShopLoginChangeOserctorAndIconState());
  }
}
