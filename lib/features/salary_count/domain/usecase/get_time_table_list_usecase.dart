import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/salary_count/data/model/request/get_all_time_table_params.dart';
import 'package:starter_application/features/salary_count/domain/entity/time_table_list_entity.dart';
import 'package:starter_application/features/salary_count/domain/repository/isalary_count_repository.dart';

@singleton
class GetTimeTableListUsecase extends UseCase<TimeTableListEntity, GetAllTimeTableParams> {
  final ISalaryCountRepository iSalaryCountRepository;

  GetTimeTableListUsecase(this.iSalaryCountRepository);

  @override
  Future<Result<AppErrors, TimeTableListEntity>> call(GetAllTimeTableParams param) {
    return iSalaryCountRepository.getAllTimeTable(param);
  }
}