import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/account/data/model/request/check_exist_phone_params.dart';
import 'package:starter_application/features/account/domain/repository/iaccount_repository.dart';

@singleton
class CheckIfPhoneExistUsecase extends UseCase<EmptyResponse, CheckIfPhoneExistParams> {
  final IAccountRepository iAccountRepository ;

  CheckIfPhoneExistUsecase(this.iAccountRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(CheckIfPhoneExistParams param) {
    return iAccountRepository.checkIfPhoneExist(param);
  }
}