import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/mylife/data/model/request/get_appointment_request.dart';
import 'package:starter_application/features/mylife/domain/entity/appointment_entity.dart';
import 'package:starter_application/features/mylife/domain/repository/imylife_repository.dart';

@injectable
class GetAppointmentsUseCase
    extends UseCase<AppointmentEntity, GetAppointmentRequest> {
  IMylifeRepository _iMylifeRepository;

  GetAppointmentsUseCase(this._iMylifeRepository);

  @override
  Future<Result<AppErrors, AppointmentEntity>> call(
      GetAppointmentRequest param) async {
    return await _iMylifeRepository.getAllAppointments(param);
  }
}
