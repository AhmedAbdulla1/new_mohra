import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/user/data/model/request/delete_address_params.dart';
import 'package:starter_application/features/user/domain/repository/iuser_repository.dart';

@singleton
class DeleteAddressUsecase extends UseCase<EmptyResponse, DeleteAddressParams> {
  final IUserRepository iUserRepository ;

  DeleteAddressUsecase(this.iUserRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(DeleteAddressParams param) {
    return iUserRepository.deleteAddress(param);
  }
}