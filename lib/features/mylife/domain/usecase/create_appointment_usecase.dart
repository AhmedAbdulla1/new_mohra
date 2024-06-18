import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/mylife/data/model/request/create_appointment_params.dart';
import 'package:starter_application/features/mylife/domain/entity/appointment_entity.dart';
import 'package:starter_application/features/mylife/domain/repository/imylife_repository.dart';

@injectable
class CreateAppointmentUseCase
    extends UseCase<AppointmentItemEntity, CreateAppointmentRequest> {
  IMylifeRepository _iMylifeRepository;

  CreateAppointmentUseCase(this._iMylifeRepository);

  @override
  Future<Result<AppErrors, AppointmentItemEntity>> call(
      CreateAppointmentRequest param) async {
    return await _iMylifeRepository.createAppointment(param);
  }
}
