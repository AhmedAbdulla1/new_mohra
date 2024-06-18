import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/user/data/model/request/change_password_params.dart';
import 'package:starter_application/features/user/domain/repository/iuser_repository.dart';

@singleton
class ChangePasswordUsecase extends UseCase<EmptyResponse, ChangePasswordParams> {
  final IUserRepository iUserRepository ;

  ChangePasswordUsecase(this.iUserRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(ChangePasswordParams param) {
    return iUserRepository.changePassword(param);
  }
}