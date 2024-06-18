import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/event/data/model/request/get_my_running_events_param.dart';
import 'package:starter_application/features/event_orginizer/domain/entity/event_tickets_entity.dart';

import '../repository/ievent_orginizer_repository.dart';
@injectable
class GetEventTicketssUseCase
    extends UseCase<EventTicketssEntity, GetEventTicketsParam> {
  final IEventOrginizerRepository repository;

  GetEventTicketssUseCase(this.repository);

  @override
  Future<Result<AppErrors, EventTicketssEntity>> call(GetEventTicketsParam param) {
    return repository.getEventTickets(param);
  }


}
