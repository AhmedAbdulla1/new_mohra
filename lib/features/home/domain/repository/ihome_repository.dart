import 'package:starter_application/core/repositories/repository.dart';
import 'package:starter_application/features/home/data/model/request/get_weather_prams.dart';
import 'package:starter_application/features/home/domain/entity/weather_entity.dart';

import '../../../../core/errors/app_errors.dart';
import '../../../../core/params/no_params.dart';
import '../../../../core/results/result.dart';
import '../entity/banners_entity.dart';

abstract class IHomeRepository extends Repository {
  Future<Result<AppErrors, BannersEntity>> getAllBanners(NoParams param);
  Future<Result<AppErrors, WeatherEntity>> getWeather(GetWeatherParams param);
}
