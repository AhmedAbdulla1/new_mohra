import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/account/data/model/request/check_exist_userName_params.dart';
import 'package:starter_application/features/account/domain/repository/iaccount_repository.dart';

@singleton
class CheckIfUsernameExistUsecase extends UseCase<EmptyResponse, CheckIfUsernameExistParams> {
  final IAccountRepository iAccountRepository ;

  CheckIfUsernameExistUsecase(this.iAccountRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(CheckIfUsernameExistParams param) {
    return iAccountRepository.checkIfUsernameExist(param);
  }
}