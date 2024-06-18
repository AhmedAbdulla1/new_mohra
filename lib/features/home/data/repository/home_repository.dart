import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/common/extensions/extensions.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/home/data/datasource/ihome_remote.dart';
import 'package:starter_application/features/home/data/model/request/get_weather_prams.dart';
import 'package:starter_application/features/home/domain/entity/banners_entity.dart';
import 'package:starter_application/features/home/domain/entity/weather_entity.dart';
import 'package:starter_application/features/home/domain/repository/ihome_repository.dart';
import 'package:starter_application/features/home/domain/usecase/get_weather_usecase.dart';

@Injectable(as: IHomeRepository)
class HomeRepository extends IHomeRepository {
  final IHomeRemoteSource iHomeRemoteSource;

  HomeRepository(this.iHomeRemoteSource);

  @override
  Future<Result<AppErrors, BannersEntity>> getAllBanners(NoParams param) async{
    final remote = await iHomeRemoteSource.getAllBanners(param);
    return remote.result<BannersEntity>();
  }

  @override
  Future<Result<AppErrors, WeatherEntity>> getWeather(GetWeatherParams param) async{
    final remote = await iHomeRemoteSource.getWeather(param);
    remote.result<WeatherEntity>().data?.data.toString().logD;
      return remote.result<WeatherEntity>();
  }

}
