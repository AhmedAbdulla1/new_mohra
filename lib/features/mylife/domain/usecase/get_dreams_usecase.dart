import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/mylife/domain/entity/DreamListEntity.dart';
import 'package:starter_application/features/mylife/domain/repository/imylife_repository.dart';

@injectable
class GetDreamsUseCase extends UseCase<DreamListEntity, NoParams> {
  IMylifeRepository _iMylifeRepository;

  GetDreamsUseCase(this._iMylifeRepository);

  @override
  Future<Result<AppErrors, DreamListEntity>> call(NoParams param)  {
    return  _iMylifeRepository.getAllDreams(param);
  }
}
