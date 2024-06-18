import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/event/data/model/request/get_my_running_events_param.dart';

import '../entity/my_running_events_entity.dart';
import '../repository/ievent_orginizer_repository.dart';
@injectable
class GetMyRunningEventsUseCase
    extends UseCase<MyRunningEventsEntity, GetMyRunningEventsParam> {
  final IEventOrginizerRepository repository;

  GetMyRunningEventsUseCase(this.repository);

  @override
  Future<Result<AppErrors, MyRunningEventsEntity>> call(GetMyRunningEventsParam param) {
    return repository.getMyRunningEvents(param);
  }


}
