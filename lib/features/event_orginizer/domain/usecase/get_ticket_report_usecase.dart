import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/event_orginizer/data/model/request/event_details_params.dart';
import 'package:starter_application/features/event_orginizer/domain/entity/get_ticket_report_response_entity.dart';

import '../repository/ievent_orginizer_repository.dart';
@injectable
class GetTicketReportUsecase
    extends UseCase<GetTicketReportResponseEntity, EventDetailsParams> {
  final IEventOrginizerRepository repository;

  GetTicketReportUsecase(this.repository);

  @override
  Future<Result<AppErrors, GetTicketReportResponseEntity>> call(EventDetailsParams param) {
    return repository.getTicketReport(param);
  }


}
