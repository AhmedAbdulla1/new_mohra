import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/errors/app_errors.dart';


part 'mobile_ads_state.dart';

part 'mobile_ads_cubit.freezed.dart';

class MobileAdsCubit extends Cubit<MobileAdsState> {

  MobileAdsCubit() : super(const MobileAdsState.mobileAdsInitState());

 
}
