import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/extensions.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/net/create_model_interceptor/weather_interprator.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/home/data/model/request/get_weather_prams.dart';
import 'package:starter_application/features/home/data/model/response/banners_model.dart';
import 'package:starter_application/features/home/data/model/response/weather_model.dart';
import 'package:starter_application/features/home/domain/entity/banners_entity.dart';
import 'package:starter_application/features/home/domain/usecase/get_weather_usecase.dart';

import '../../../../core/constants/enums/http_method.dart';
import '../../../../core/net/api_url.dart';
import 'ihome_remote.dart';

@Injectable(as: IHomeRemoteSource)
class HomeRemoteSource extends IHomeRemoteSource {
  @override
  Future<Either<AppErrors, BannersModel>> getAllBanners(NoParams param) {
    return request(
      converter: (json) => BannersModel.fromJson(json),
      method: HttpMethod.GET,
      url: APIUrls.getAllBanners,
    );
  }

  @override
  Future<Either<AppErrors, WeatherModel>> getWeather(
      GetWeatherParams param) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://newstaging.mohraapp.com${APIUrls.getWeather}?Latitude=${param.lat}&Longitude=${param.lon}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Right(WeatherModel.fromJson(data));
      } else if (response.statusCode == 400) {
        return Left(AppErrors.badRequestError());
      }else{
        return Left(AppErrors.internalServerError());
      }
    } catch (e) {
      return Left(CustomError(message: e.toString()));
    }

    // return request(
    //   converter: (json) {
    //     print('json' + json);
    //     return WeatherModel.fromJson(json);
    //   },
    //   createModelInterceptor: const WeatherInterceptor(),
    //   method: HttpMethod.GET,
    //   url: APIUrls.getWeather,
    //   queryParameters: param.toMap(),
    //   baseUrl: "https://newstaging.mohraapp.com",
    // );
  }
}
