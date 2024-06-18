import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/salary_count/data/model/request/create_time_table_params.dart';
import 'package:starter_application/features/salary_count/domain/repository/isalary_count_repository.dart';

@singleton
class CreateTimeTableUsecase extends UseCase<EmptyResponse, CreateTimeTableParams> {
  final ISalaryCountRepository iSalaryCountRepository;

  CreateTimeTableUsecase(this.iSalaryCountRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(CreateTimeTableParams param) {
    return iSalaryCountRepository.createTimeTable(param);
  }
}