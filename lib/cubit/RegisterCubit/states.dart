import 'package:my_app_shop/model/login_model.dart';

abstract class ShopRegisterState {}

class ShopRegisterInitialState extends ShopRegisterState {}

class ShopRegisterLoadingState extends ShopRegisterState {}

class ShopRegisterSuccessState extends ShopRegisterState {
  final ShopLoginModel? RegisterModel;
  ShopRegisterSuccessState(this.RegisterModel) {}
}

class ShopRegisterErorrState extends ShopRegisterState {
  final String? Erorr;
  ShopRegisterErorrState(this.Erorr);
}

class ShopRegisterChangeOserctorAndIconState extends ShopRegisterState {}

class ShopRegisterCheckInternet extends ShopRegisterState {}
