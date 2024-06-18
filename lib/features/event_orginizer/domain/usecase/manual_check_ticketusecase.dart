import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';

import '../../data/model/request/manual_event_check_params.dart';
import '../repository/ievent_orginizer_repository.dart';
@injectable
class ManualCheckTicketUsecase
    extends UseCase<EmptyResponse, ManualCheckEventParams> {
  final IEventOrginizerRepository repository;

  ManualCheckTicketUsecase(this.repository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(ManualCheckEventParams param) {
    return repository.manualCheckingEventTicket(param);
  }


}
