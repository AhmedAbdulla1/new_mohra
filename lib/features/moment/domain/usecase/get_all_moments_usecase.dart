import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/moment/data/model/request/get_all_moments_request.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import 'package:starter_application/features/moment/domain/repository/imoment_repository.dart';

@injectable
class GetMomentsUseCase extends UseCase<MomentEntity, GetMomentsRequest> {
  IMomentRepository _iMomentRepository;

  GetMomentsUseCase(this._iMomentRepository);

  @override
  Future<Result<AppErrors, MomentEntity>> call(GetMomentsRequest param) async {
    return await _iMomentRepository.getMoments(param);
  }
}
