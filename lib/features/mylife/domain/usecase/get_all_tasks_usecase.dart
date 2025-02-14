import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/mylife/data/model/request/get_all_tasks_request.dart';
import 'package:starter_application/features/mylife/domain/entity/task_entity.dart';
import 'package:starter_application/features/mylife/domain/repository/imylife_repository.dart';

@injectable
class GetTasksUseCase extends UseCase<TaskEntity, GetAllTasksRequest> {
  IMylifeRepository _iMylifeRepository;

  GetTasksUseCase(this._iMylifeRepository);

  @override
  Future<Result<AppErrors, TaskEntity>> call(GetAllTasksRequest param) async {
    return await _iMylifeRepository.getAllTasks(param);
  }
}
