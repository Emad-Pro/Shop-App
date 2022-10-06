import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/components/components.dart';
import 'package:my_app_shop/layout/Shop/Pages/Cateogries/Cateogries.dart';
import 'package:my_app_shop/layout/Shop/Pages/Favorites/Favorites.dart';
import 'package:my_app_shop/layout/Shop/Pages/Orders/getOrder.dart';
import 'package:my_app_shop/layout/Shop/Pages/Orders/getOrderDetils.dart';
import 'package:my_app_shop/layout/Shop/Pages/Products/Products.dart';
import 'package:my_app_shop/layout/Shop/Pages/Search/Search.dart';
import 'package:my_app_shop/layout/Shop/Pages/Settings/Settings.dart';
import 'package:my_app_shop/layout/Shop/Pages/home/Home.dart';
import 'package:my_app_shop/layout/Shop/cubit/states.dart';
import 'package:my_app_shop/model/Catigores_model.dart';
import 'package:my_app_shop/model/FavoritesPage_model.dart';
import 'package:my_app_shop/model/ProductDetils_Model.dart';
import 'package:my_app_shop/model/login_model.dart';
import 'package:my_app_shop/shared/remote/dioHelper/dio_helper.dart';

import '../../../model/Add_AddrssModel.dart';
import '../../../model/Add_OrderModel.dart';
import '../../../model/Cancel_OrderModel.dart';
import '../../../model/CartsModel.dart';
import '../../../model/CategoriesItem_model.dart';
import '../../../model/Delete_AddressModel.dart';
import '../../../model/Favorites_model.dart';
import '../../../model/GetCartItem.dart';
import '../../../model/Get_AddressModel.dart';
import '../../../model/Get_OrderDetils.dart';
import '../../../model/Get_OrderModel.dart';
import '../../../model/Home_model.dart';
import '../../../model/UpdateItemCart.dart';
import '../../../model/Update_AddressModel.dart';
import '../../../shared/remote/SharedPreferences/CacheHelper.dart';
import '../../../shared/remote/endpoint.dart';

class ShopCubit extends Cubit<Shopstates> {
  ShopCubit() : super(ShopInitialStates());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreen = [
    ShopHome(),
    Products(),
    Favorites(),
    Cateogries(),
    Search(),
    Settings(),
  ];
  void changeBottomScreen(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNaveState());
  }

  bool seemore = true;
  int a = 0;
  void changeitemcaros() {
    seemore ? seemore = false : seemore = true;
    emit(ShopChangeSeeMoreState());
  }

  HomeModel? homeModel;
  Map<int, bool>? favo = {};
  Map<int, bool>? cart = {};
  void getHomeData() {
    emit(ShopLoadingDataHomeState());
    DioHelper.getData(url: Home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value!.data);
      //print(homeModel!.data!.Banners![0].image);
      homeModel!.data!.Products!.forEach((element) {
        favo!.addAll({element.id!: element.favorites!});
        cart!.addAll({element.id!: element.inCart!});
      });
      print(favo);
      emit(ShopSuccessHomeDataState());
    }).catchError((onError) {
      print(onError);
      emit(ShopErrorHomeDataState());
    });
  }

  CatigoresModel? catigoresModel;
  void getCatigoresData() {
    emit(ShopLoadingDatacCatigoresState());
    DioHelper.getData(url: CATEGORIES).then((value) {
      catigoresModel = CatigoresModel.fromJson(value!.data);
      //print(catigoresModel!.data!.current_page);
      emit(ShopSuccessCatigoresDataState());
    }).catchError((onError) {
      print(onError);
      emit(ShopErrorCatigoresDataState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFAVORITES(int? ProductId) {
    if (favo![ProductId] == false) {
      favo![ProductId!] = true;
    } else if (favo![ProductId] == true) {
      favo![ProductId!] = false;
    }
    emit(ShopChangeFavoritesDataState());
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': ProductId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJason(value.data);
      print(value.data);
      if (!changeFavoritesModel!.status!) {
        if (favo![ProductId] == false) {
          favo![ProductId!] = true;
        } else if (favo![ProductId] == true) {
          favo![ProductId!] = false;
        }
      } else {
        getFavoritsData();
      }
      emit(ShopSuccessFavoritesDataState());
    }).catchError((onError) {
      if (favo![ProductId] == false) {
        favo![ProductId!] = true;
      } else if (favo![ProductId] == true) {
        favo![ProductId!] = false;
      }
      emit(ShopErrorFavoritesDataState());
      print(onError.toString());
    });
  }

  Cart? cartModel;
  void AddRemoveCart(int? ProductId) {
    if (cart![ProductId] == false) {
      cart![ProductId!] = true;
    } else if (cart![ProductId] == true) {
      cart![ProductId!] = false;
    }
    emit(ShopChangeCartsDataState());
    DioHelper.postData(
            url: PLUSmINUITEM, data: {'product_id': ProductId}, token: token)
        .then((value) {
      cartModel = Cart.fromJson(value.data);
      if (!cartModel!.status!) {
        if (cart![ProductId] == false) {
          cart![ProductId!] = true;
        } else if (cart![ProductId] == true) {
          cart![ProductId!] = false;
        }
      } else {
        getCartItem();
      }
      emit(ShopSuccessCartsDataState());
    }).catchError((onError) {
      if (cart![ProductId] == false) {
        cart![ProductId!] = true;
      } else if (cart![ProductId] == true) {
        cart![ProductId!] = false;
      }
      emit(ShopErrorCartsDataState());
      print(onError.toString());
    });
  }

  FavoritesModel? favoritsModel;
  void getFavoritsData() {
    emit(ShopLoadingGetFavoritesDataState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritsModel = FavoritesModel.fromJson(value!.data);
      emit(ShopSuccessFavoritesDataState());
    }).catchError((onError) {
      print(onError);
      emit(ShopErrorFavoritesDataState());
    });
  }

  GetCartItem? getCartItemModel;
  void getCartItem() {
    emit(ShopLoadingGetCartsItemsDataState());
    DioHelper.getData(
      url: CHANGECART,
      token: token,
    ).then((value) {
      getCartItemModel = GetCartItem.fromJson(value!.data);
      emit(ShopSuccessGetCartsItemsDataState());
    }).catchError((onError) {
      print(onError);
      emit(ShopErrorGetCartsItemsDataState());
    });
  }

  GetProductDetilsModel? getProductDetilsModel;
  void GetProductDetils({int? itemprodcut}) {
    emit(ShopLoadingGetProductDetilsState());
    DioHelper.getData(
            url: '${PRODUCTSDETIELS + itemprodcut.toString()}', token: token)
        .then((value) {
      getProductDetilsModel = GetProductDetilsModel.fromJson(value!.data);
      emit(ShopSuccessGetProductDetilsState());
    }).catchError((onError) {
      print(onError);
      emit(ShopErrorGetProductDetilsState());
    });
  }

  CategoriesItemModel? getCategoriesItemModel;
  void getCategoriesItem({int? ItemModel}) {
    emit(ShopLoadingCategoriesItemsDataState());
    DioHelper.getData(
      url: "${CATEGORIES + ItemModel.toString()}",
      token: token,
    ).then((value) {
      getCategoriesItemModel = CategoriesItemModel.fromJson(value!.data);

      emit(ShopSuccessCategoriesItemsDataState());
    }).catchError((onError) {
      print(onError);
      emit(ShopErrorCategoriesItemsDataState());
    });
  }

  UpdateItemCartModel? updateItemCart;
  void UpdateItemCart({int? ProductId, int? IdProductCart, index}) {
    emit(ShopLoadingUpdateCartItemDataState());
    DioHelper.putData(
        url: "${CHANGECART + IdProductCart.toString()}",
        token: token,
        data: {"quantity": ProductId}).then((value) {
      updateItemCart = UpdateItemCartModel.fromJson(value.data);
      getCartItem();
      print(value.data);
      emit(ShopSuccessUpdateCartItemDataState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorUpdateCartItemDataState());
    });
  }

  AddAdressModel? addAdress;
  void addAddress(
      {required String? name,
      required String? city,
      required String? region,
      required String? details,
      String? notes,
      String? latitude,
      String? longitude}) {
    emit(ShopLoadingAddAddress());
    DioHelper.postData(url: ADDADDRESS, token: token, data: {
      "name": name,
      "city": city,
      "region": region,
      "details": details,
      "notes": notes,
      "latitude": latitude,
      "longitude": longitude,
    }).then((value) {
      addAdress = AddAdressModel.fromJson(value.data);
      print(value.data);
      getAddressData();
      emit(ShopSuccessAddAddress());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErorrAddAddress());
    });
  }

  GetAdressModel? getAddressModel;
  void getAddressData() {
    emit(ShopLoadingGetAddress());
    DioHelper.getData(url: ADDADDRESS, token: token).then((value) {
      getAddressModel = GetAdressModel.fromJson(value!.data);
      //  print(value.data);

      emit(ShopSuccessGetAddress());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErorrGetAddress());
    });
  }

  UpdateAddressModel? updateAddress;
  void UpdateAddressData(
      {required int ProductId,
      required String? name,
      required String? city,
      required String? region,
      required String? details,
      String? notes,
      String? latitude,
      String? longitude}) {
    emit(ShopLoadingUpdateAddress());
    DioHelper.putData(url: "${ADDADDRESS}/${ProductId}", token: token, data: {
      "name": name,
      "city": city,
      "region": region,
      "details": details,
      "notes": notes,
      "latitude": latitude,
      "longitude": longitude,
    }).then((value) {
      updateAddress = UpdateAddressModel.fromJson(value.data);
      print(value.data);
      getAddressData();
      emit(ShopSuccessUpdateAddress());
    }).catchError((onError) {
      emit(ShopErorrUpdateAddress());
      print(onError);
    });
  }

  DeleteAdressModel? deleteAdressModel;
  void DeleteAddressData(int? idAddress) {
    emit(ShopLoadingDeleteAddress());
    DioHelper.deleteData(url: '${ADDADDRESS}/${idAddress}', token: token)
        .then((value) {
      deleteAdressModel = DeleteAdressModel.fromJson(value.data);
      print(value.data);
      getAddressData();
      emit(ShopSuccessDeleteAddress());
    }).catchError((onError) {
      print(onError);
      emit(ShopErorrDeleteAddress());
    });
  }

  AddOrderModel? addOrderModel;
  void addOrder({int? addressid, int? paymethod, bool? point}) {
    emit(ShopLoadingOrderAdd());
    DioHelper.postData(url: ORDERS, token: token, data: {
      'address_id': addressid,
      'payment_method': paymethod,
      'use_points': false,
    }).then((value) {
      addOrderModel = AddOrderModel.fromJson(value.data);
      // getCartItem();
      GetOrderData();
      //  print(value.data);
      emit(ShopSuccessOrderAdd());
    }).catchError((onError) {
      print(onError);
      //emit(ShopErorrOrderAdd());
    });
  }

  GetOrderModel? getOrderModel;
  void GetOrderData() {
    emit(ShopLoadingOrderGet());
    DioHelper.getData(url: ORDERS, token: token).then((value) {
      getOrderModel = GetOrderModel.fromJson(value!.data);

      print(value.data);
      emit(ShopSuccessOrderGet());
    }).catchError((onError) {
      print(onError);
      emit(ShopErorrOrderGet());
    });
  }

  GetOrderDetilsModel? getOrderDetilsModel;
  void GetOrderDetils({int? idOrder}) {
    emit(ShopLoadingOrderGetDetils());
    DioHelper.getData(url: "${ORDERS}/${idOrder}", token: token).then((value) {
      getOrderDetilsModel = GetOrderDetilsModel.fromJson(value!.data);
      print(value.data);
      emit(ShopSuccessOrderGetDetils());
    }).catchError((onError) {
      print(onError);
      emit(ShopErorrOrderGetDetils());
    });
  }

  CancelOrderModel? cancelOrderModel;
  void CancelOrder({int? idOrder}) {
    emit(ShopLoadingOrderCancel());
    DioHelper.getData(url: "${ORDERS}/${idOrder}/cancel", token: token)
        .then((value) {
      cancelOrderModel = CancelOrderModel.fromJson(value!.data);
      GetOrderData();
      print(value.data);
      emit(ShopSuccessOrderCancel());
    }).catchError((onError) {
      print(onError);
      emit(ShopErorrOrderCancel());
    });
  }

  int? selectPaymentValue = 1;
  void paymentvalue(value) {
    if (value == 'كاش') selectPaymentValue = 1;
    if (value == 'فيزا') selectPaymentValue = 2;
    print(selectPaymentValue.toString());
    emit(paymentstate());
  }

  bool isDark = true;
  void ChangeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(DarkModeChange());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(DarkModeChange());
      });
    }
  }
}
