import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/home/domain/entity/weather_entity.dart';
import 'package:starter_application/features/home/domain/repository/ihome_repository.dart';

import '../../../../core/params/no_params.dart';
import '../entity/banners_entity.dart';
@injectable
class GetAllBannersUseCase extends UseCase<BannersEntity, NoParams> {
  final IHomeRepository repository;

  GetAllBannersUseCase(this.repository);
  @override
  Future<Result<AppErrors, BannersEntity>> call(NoParams param) {
    return repository.getAllBanners(param);
  }
}