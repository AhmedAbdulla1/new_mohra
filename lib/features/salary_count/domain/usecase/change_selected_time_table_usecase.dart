import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/salary_count/data/model/request/change_selected_time_table_params.dart';
import 'package:starter_application/features/salary_count/domain/repository/isalary_count_repository.dart';

@singleton
class ChangeSelectedTimeTableUsecase extends UseCase<EmptyResponse, ChangeSelectedTimeTableParams> {
  final ISalaryCountRepository iSalaryCountRepository;

  ChangeSelectedTimeTableUsecase(this.iSalaryCountRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(ChangeSelectedTimeTableParams param) {
    return iSalaryCountRepository.changeSelectedTimeTable(param);
  }
}