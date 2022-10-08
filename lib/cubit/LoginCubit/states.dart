import 'package:my_app_shop/model/login_model.dart';

abstract class ShopLoginState {}

class ShopLoginInitialState extends ShopLoginState {}

class ShopLoginLoadingState extends ShopLoginState {}

class ShopLoginSuccessState extends ShopLoginState {
  final ShopLoginModel? LoginModel;
  ShopLoginSuccessState(this.LoginModel) {}
}

class ShopLoginErorrState extends ShopLoginState {
  final String? Erorr;
  ShopLoginErorrState(this.Erorr);
}

class ShopLoginChangeOserctorAndIconState extends ShopLoginState {}

class ShopLoginCheckInternet extends ShopLoginState {}
