import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/salary_count/data/model/request/change_order_request.dart';
import 'package:starter_application/features/salary_count/domain/repository/isalary_count_repository.dart';

@singleton
class ChangeTimeTableOrderUsecase extends UseCase<EmptyResponse, ChangeTimeTableOrderRequest> {
  final ISalaryCountRepository iSalaryCountRepository;

  ChangeTimeTableOrderUsecase(this.iSalaryCountRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(ChangeTimeTableOrderRequest param) {
    return iSalaryCountRepository.changeTimeTableOrder(param);
  }
}