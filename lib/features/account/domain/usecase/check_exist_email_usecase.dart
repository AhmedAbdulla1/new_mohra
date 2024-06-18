import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/account/data/model/request/check_exist_email_params.dart';
import 'package:starter_application/features/account/domain/repository/iaccount_repository.dart';

@singleton
class CheckIfEmailExistUsecase extends UseCase<EmptyResponse, CheckIfEmailExistParams> {
  final IAccountRepository iAccountRepository ;

  CheckIfEmailExistUsecase(this.iAccountRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(CheckIfEmailExistParams param) {
    return iAccountRepository.checkIfEmailExist(param);
  }
}