import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/event_orginizer/data/model/request/search_event_params.dart';

import '../entity/my_running_events_entity.dart';
import '../repository/ievent_orginizer_repository.dart';
@injectable
class SearchMyRunningEventsUseCase
    extends UseCase<MyRunningEventsEntity, SearchEventParams> {
  final IEventOrginizerRepository repository;

  SearchMyRunningEventsUseCase(this.repository);

  @override
  Future<Result<AppErrors, MyRunningEventsEntity>> call(SearchEventParams param) {
    return repository.searchMyRunningEvents(param);
  }


}
