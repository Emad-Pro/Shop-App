import 'package:my_app_shop/model/Favorites_model.dart';
import 'package:my_app_shop/model/login_model.dart';

abstract class Shopstates {}

class ShopInitialStates extends Shopstates {}

class ShopChangeBottomNaveState extends Shopstates {}

class ShopChangeSeeMoreState extends Shopstates {}

class ShopLoadingDataHomeState extends Shopstates {}

class ShopSuccessHomeDataState extends Shopstates {}

class ShopErrorHomeDataState extends Shopstates {}

class ShopLoadingDatacCatigoresState extends Shopstates {}

class ShopSuccessCatigoresDataState extends Shopstates {}

class ShopErrorCatigoresDataState extends Shopstates {}

class ShopSuccessFavoritesDataState extends Shopstates {}

class ShopErrorFavoritesDataState extends Shopstates {}

class ShopChangeFavoritesDataState extends Shopstates {}

class ShopLoadingGetFavoritesDataState extends Shopstates {}

class ShopSuccessGetFavoritesDataState extends Shopstates {}

class ShopErrorGetFavoritesDataState extends Shopstates {}

class ShopUserLoadingDataState extends Shopstates {}

class ShopUserErorrDataState extends Shopstates {}

class ShopUserUpdateLoadingDataState extends Shopstates {}

class ShopUserUpdateSuccessDataState extends Shopstates {
  final ShopLoginModel? loginModel;

  ShopUserUpdateSuccessDataState(this.loginModel);
}

class ShopUserUpdateErorrDataState extends Shopstates {}

class ShopSuccessCartsDataState extends Shopstates {}

class ShopErrorCartsDataState extends Shopstates {}

class ShopChangeCartsDataState extends Shopstates {}

class ShopLoadingGetCartsItemsDataState extends Shopstates {}

class ShopSuccessGetCartsItemsDataState extends Shopstates {}

class ShopErrorGetCartsItemsDataState extends Shopstates {}

class ShopLoadingGetProductDetilsState extends Shopstates {}

class ShopSuccessGetProductDetilsState extends Shopstates {}

class ShopErrorGetProductDetilsState extends Shopstates {}

class ShopLoadingCategoriesItemsDataState extends Shopstates {}

class ShopSuccessCategoriesItemsDataState extends Shopstates {}

class ShopErrorCategoriesItemsDataState extends Shopstates {}

class ShopLoadingUpdateCartItemDataState extends Shopstates {}

class ShopSuccessUpdateCartItemDataState extends Shopstates {}

class ShopErrorUpdateCartItemDataState extends Shopstates {}

class ShopLoadingAddAddress extends Shopstates {}

class ShopSuccessAddAddress extends Shopstates {}

class ShopErorrAddAddress extends Shopstates {}

class ShopLoadingGetAddress extends Shopstates {}

class ShopSuccessGetAddress extends Shopstates {}

class ShopErorrGetAddress extends Shopstates {}

class ShopLoadingDeleteAddress extends Shopstates {}

class ShopSuccessDeleteAddress extends Shopstates {}

class ShopErorrDeleteAddress extends Shopstates {}

class ShopLoadingUpdateAddress extends Shopstates {}

class ShopSuccessUpdateAddress extends Shopstates {}

class ShopErorrUpdateAddress extends Shopstates {}

class ShopLoadingOrderAdd extends Shopstates {}

class ShopSuccessOrderAdd extends Shopstates {}

class ShopErorrOrderAdd extends Shopstates {}

class ShopLoadingOrderGet extends Shopstates {}

class ShopSuccessOrderGet extends Shopstates {}

class ShopErorrOrderGet extends Shopstates {}

class ShopLoadingOrderGetDetils extends Shopstates {}

class ShopSuccessOrderGetDetils extends Shopstates {}

class ShopErorrOrderGetDetils extends Shopstates {}

class ShopLoadingOrderCancel extends Shopstates {}

class ShopSuccessOrderCancel extends Shopstates {}

class ShopErorrOrderCancel extends Shopstates {}

class paymentstate extends Shopstates {}

class DarkModeChange extends Shopstates {}
