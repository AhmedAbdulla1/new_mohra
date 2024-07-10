import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/account/data/model/request/verify_opt_prames.dart';
import 'package:starter_application/features/account/domain/repository/iaccount_repository.dart';

@singleton
class VerifyOTpUseCase extends UseCase<EmptyResponse, VerifyOtpParams> {
  final IAccountRepository iAccountRepository ;

  VerifyOTpUseCase(this.iAccountRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(VerifyOtpParams param) {
    return iAccountRepository.verifyOTP(param);
  }
}