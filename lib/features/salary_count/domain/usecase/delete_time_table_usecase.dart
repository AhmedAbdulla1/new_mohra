import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/salary_count/data/model/request/delete_time_table_params.dart';
import 'package:starter_application/features/salary_count/domain/repository/isalary_count_repository.dart';

@singleton
class DeleteTimeTableUsecase extends UseCase<EmptyResponse, DeleteTimeTableParams> {
  final ISalaryCountRepository iSalaryCountRepository;

  DeleteTimeTableUsecase(this.iSalaryCountRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(DeleteTimeTableParams param) {
    return iSalaryCountRepository.deleteTimeTable(param);
  }
}