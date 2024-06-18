import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/mylife/data/model/request/get_positive_request.dart';
import 'package:starter_application/features/mylife/domain/entity/PositiveListEntity.dart';
import 'package:starter_application/features/mylife/domain/repository/imylife_repository.dart';

@injectable
class GetPositivesUseCase
    extends UseCase<PositiveListEntity, GetPositiveRequest> {
  IMylifeRepository _iMylifeRepository;

  GetPositivesUseCase(this._iMylifeRepository);

  @override
  Future<Result<AppErrors, PositiveListEntity>> call(GetPositiveRequest param) {
    return _iMylifeRepository.getAllPositives(param);
  }
}
