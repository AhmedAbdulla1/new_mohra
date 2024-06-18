import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';

import '../../../event/data/model/request/get_event_ticket_request.dart';
import '../../../event/domain/entity/event_ticket_entity.dart';
import '../repository/ievent_orginizer_repository.dart';
@injectable
class GetTicketDetailsUsecase
    extends UseCase<EventTicketEntity, GetEventTicketRequest> {
  final IEventOrginizerRepository repository;

  GetTicketDetailsUsecase(this.repository);

  @override
  Future<Result<AppErrors, EventTicketEntity>> call(GetEventTicketRequest param) {
    return repository.getEventTicket(param);
  }


}
