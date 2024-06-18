import 'package:injectable/injectable.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/shop/data/model/response/get_taxfee_model.dart';
import 'package:starter_application/features/shop/domain/repository/ishop_repository.dart';
@singleton
class GetTaxFeeUseCase
    extends UseCase<GetSettingModel, NoParams> {
  final IShopRepository repository;

  GetTaxFeeUseCase(this.repository);
  @override
  Future<Result<AppErrors, GetSettingModel>> call(pragma) {
    return repository.getTaxFee();
  }
}
