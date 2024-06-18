import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/settings/data/model/request/update_moments_settings_params.dart';
import 'package:starter_application/features/settings/domain/repository/isettings_repository.dart';

@singleton
class UpdateMomentsSettingsUsecase extends UseCase<EmptyResponse, UpdateMomentsSettingsParams> {
  final ISettingsRepository iSettingsRepository;

  UpdateMomentsSettingsUsecase(this.iSettingsRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(UpdateMomentsSettingsParams param) {
    return iSettingsRepository.updateMomentsSettings(param);
  }
}