import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/user/data/model/request/get_profile_params.dart';
import 'package:starter_application/features/user/domain/entity/get_profile_entity.dart';
import 'package:starter_application/features/user/domain/repository/iuser_repository.dart';

@singleton
class GetUserProfileUseCase extends UseCase<GetProfileEntity, GetProfileParams> {
  final IUserRepository iUserRepository ;

  GetUserProfileUseCase(this.iUserRepository);

  @override
  Future<Result<AppErrors, GetProfileEntity>> call(GetProfileParams param) {
    return iUserRepository.getUserProfile(param);
  }
}