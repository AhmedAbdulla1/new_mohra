import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/health/domain/entity/health_result_response_entity.dart';
import 'package:starter_application/features/health/domain/repository/ihealth_repository.dart';

@singleton
class GetUserResultsUsecase extends UseCase<HealthResultResponseEntity , NoParams>{

  final IHealthRepository iHealthRepository;
  GetUserResultsUsecase(this.iHealthRepository);

  @override
  Future<Result<AppErrors, HealthResultResponseEntity>> call(NoParams param) {
    return iHealthRepository.getUserResults(param);
  }

}