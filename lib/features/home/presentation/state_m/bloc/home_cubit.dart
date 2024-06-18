import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter_application/core/common/extensions/extensions.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/features/home/data/model/request/get_weather_prams.dart';
import 'package:starter_application/features/home/domain/entity/weather_entity.dart';
import 'package:starter_application/features/home/domain/usecase/get_weather_usecase.dart';

import '../../../../../core/params/no_params.dart';
import '../../../../../di/service_locator.dart';
import '../../../domain/entity/banners_entity.dart';
import '../../../domain/usecase/get_all_banners_usecase.dart';

part 'home_state.dart';

part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState.homeInitState());
  Future<WeatherEntity> getWeather(GetWeatherParams param) async {
    emit(const HomeState.weatherLoadingState());
    final result = await getIt<GetWeatherUseCase>()(param);
    result.data?.data.toString().logD;
    return result.data!;
    result.pick(
      onData: (data) {
        print(data.data.toString());
        return emit(HomeState.weatherLoadedState(data));
      },
      onError: (error) => emit(HomeState.weatherLoadingError(error, () {
        this.getWeather(param);
      })),
    );
  }
  getAllBanners(NoParams param) async {
    emit(const HomeState.bannersLoadingState());
    final result = await getIt<GetAllBannersUseCase>()(param);
    result.pick(
      onData: (data) => emit(HomeState.bannersLoadedState(data)),
      onError: (error) => emit(HomeState.bannersLoadingError(error, () {
        this.getAllBanners(param);
      })),
    );
  }
}
