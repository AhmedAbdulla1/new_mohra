import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/account/data/model/request/verify_otp_request.dart';
import 'package:starter_application/features/account/domain/entity/verify_entity.dart';
import 'package:starter_application/features/account/domain/repository/iaccount_repository.dart';

@singleton
class VerifyOTpUseCase extends UseCase<VerifyEntity, VerifyOtpParams> {
  final IAccountRepository iAccountRepository ;

  VerifyOTpUseCase(this.iAccountRepository);

  @override
  Future<Result<AppErrors, VerifyEntity>> call(VerifyOtpParams param) {
    return iAccountRepository.verifyOTP(param);
  }
}