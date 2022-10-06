import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/layout/Shop/Pages/Search/Search.dart';
import 'package:my_app_shop/layout/Shop/Pages/Search/cubit/state.dart';
import 'package:my_app_shop/model/Search_Model.dart';
import 'package:my_app_shop/shared/remote/dioHelper/dio_helper.dart';

import '../../../../../components/components.dart';
import '../../../../../shared/remote/endpoint.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialStates());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;
  void SearchProduct({String? text}) {
    emit(SearchLoadingStates());
    DioHelper.postData(url: SEARCH, data: {"text": text}, token: token)
        .then((value) {
      emit(SearchSuccessStates());
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel!.data!.data);
    }).catchError((onError) {
      emit(SearchErorrStates());
      print(onError.toString());
    });
  }
}
