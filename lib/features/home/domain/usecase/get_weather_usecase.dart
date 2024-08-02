import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/home/data/model/request/get_weather_prams.dart';
import 'package:starter_application/features/home/domain/entity/weather_entity.dart';
import 'package:starter_application/features/home/domain/repository/ihome_repository.dart';

@injectable
class GetWeatherUseCase extends UseCase<WeatherEntity, GetWeatherParams> {
  final IHomeRepository repository;
  GetWeatherUseCase(this.repository);

  @override
  Future<Result<AppErrors, WeatherEntity>> call(GetWeatherParams param) {
    return repository.getWeather(param);
  }
}

