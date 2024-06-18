import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/mylife/domain/entity/client_entity.dart';
import 'package:starter_application/features/mylife/domain/repository/imylife_repository.dart';

@injectable
class GetClientsUseCase extends UseCase<ClientEntity, NoParams> {
  IMylifeRepository _iMylifeRepository;

  GetClientsUseCase(this._iMylifeRepository);

  @override
  Future<Result<AppErrors, ClientEntity>> call(NoParams) async {
    return await _iMylifeRepository.getAllClients();
  }
}
