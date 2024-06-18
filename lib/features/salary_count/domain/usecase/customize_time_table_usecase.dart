import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/salary_count/data/model/request/customize_time_table.dart';
import 'package:starter_application/features/salary_count/domain/repository/isalary_count_repository.dart';

@singleton
class CustomizeTimeTable extends UseCase<EmptyResponse, CustomizeTimeTableParams> {
  final ISalaryCountRepository iSalaryCountRepository;

  CustomizeTimeTable(this.iSalaryCountRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(CustomizeTimeTableParams param) {
    return iSalaryCountRepository.customizeTimeTable(param);
  }
}