import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_shop/cubit/onBoardingCubit/state.dart';

class OnboardingShopAppCubit extends Cubit<OnboardingShopAppState> {
  OnboardingShopAppCubit() : super(OnboardingShopAppInitialState());
  static OnboardingShopAppCubit get(context) => BlocProvider.of(context);

  bool LastPageOnBoarding = false;
}
