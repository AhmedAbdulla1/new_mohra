import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/mylife/data/model/request/check_tast_request.dart';
import 'package:starter_application/features/mylife/domain/repository/imylife_repository.dart';

@injectable
class CheckTaskUseCase extends UseCase<EmptyResponse, CheckTasksRequest> {
  IMylifeRepository _iMylifeRepository;

  CheckTaskUseCase(this._iMylifeRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(
      CheckTasksRequest param) async {
    return await _iMylifeRepository.checkTask(param);
  }
}
