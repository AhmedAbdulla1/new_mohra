import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/mylife/data/model/request/create_task_request.dart';
import 'package:starter_application/features/mylife/domain/entity/task_entity.dart';
import 'package:starter_application/features/mylife/domain/repository/imylife_repository.dart';

@injectable
class CreateTaskUseCase extends UseCase<TaskItemEntity, CreateTaskRequest> {
  IMylifeRepository _iMylifeRepository;

  CreateTaskUseCase(this._iMylifeRepository);

  @override
  Future<Result<AppErrors, TaskItemEntity>> call(
      CreateTaskRequest param) async {
    return await _iMylifeRepository.createTask(param);
  }
}
