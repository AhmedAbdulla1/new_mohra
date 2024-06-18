import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import 'package:starter_application/features/user/data/model/request/get_my_friend_moments_params.dart';
import 'package:starter_application/features/user/domain/repository/iuser_repository.dart';

@singleton
class GetMyFriendMomentsUseCase extends UseCase<MomentEntity, GetMyFriendMomentsParams> {
  final IUserRepository iUserRepository ;

  GetMyFriendMomentsUseCase(this.iUserRepository);

  @override
  Future<Result<AppErrors, MomentEntity>> call(GetMyFriendMomentsParams param) {
    return iUserRepository.getMyFriendMoments(param);
  }
}