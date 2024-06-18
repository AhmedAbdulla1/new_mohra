import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/user/data/model/request/select_address_params.dart';
import 'package:starter_application/features/user/domain/repository/iuser_repository.dart';

@singleton
class SelectAddressUsecase extends UseCase<EmptyResponse, SelectAddressParams> {
  final IUserRepository iUserRepository ;

  SelectAddressUsecase(this.iUserRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(SelectAddressParams param) {
    return iUserRepository.selectAddress(param);
  }
}