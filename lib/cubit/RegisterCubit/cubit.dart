// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/cubit/RegisterCubit/states.dart';
import 'package:my_app_shop/shared/remote/dioHelper/dio_helper.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

import '../../../../shared/remote/endpoint.dart';
import '../../model/login_model.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  //internetconniction
  bool? isConnected;
  void InterNetConniction() async {
    emit(ShopRegisterCheckInternet());
    isConnected = await SimpleConnectionChecker.isConnectedToInternet();
  }

  ShopLoginModel? RegisterModel;
  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(ShopRegisterLoadingState());
    await DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone
      },
    ).then((value) {
      RegisterModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(RegisterModel));
    }).catchError((Erorr) {
      print(Erorr.toString());
      emit(ShopRegisterErorrState(Erorr.toString()));
    });
  }

  bool PasswordVisibility = true;
  IconData suffixicon = Icons.visibility;
  Color? colorbisibility = Colors.purple[900];
  void ispassword() {
    PasswordVisibility = !PasswordVisibility;
    if (PasswordVisibility == true) {
      suffixicon = Icons.visibility_off_rounded;
      colorbisibility = Colors.purple[900];
    } else {
      suffixicon = Icons.visibility;
      colorbisibility = Colors.black;
    }

    emit(ShopRegisterChangeOserctorAndIconState());
  }
}
