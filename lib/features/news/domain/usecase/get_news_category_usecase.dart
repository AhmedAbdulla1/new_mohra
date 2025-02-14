import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/news/domain/entity/news_category_entity.dart';
import 'package:starter_application/features/news/domain/repository/inews_repository.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';

@injectable
class GetNewsCategoryUsecase
    extends UseCase<NewsCategoryEntity, GetAllNotificationParam> {
  final INewsRepository repository;

  GetNewsCategoryUsecase(this.repository);

  @override
  Future<Result<AppErrors, NewsCategoryEntity>> call(GetAllNotificationParam param) {
    return repository.getNewsCategory(param);

  }
}
