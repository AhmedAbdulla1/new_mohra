import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/news/data/model/request/news_single_category_param.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/news/domain/repository/inews_repository.dart';

@injectable
class GetSingleNewsCategoryUsecase
    extends UseCase<NewsOfCategoryEntity, NewsSingleCategoryParam> {
  final INewsRepository repository;

  GetSingleNewsCategoryUsecase(this.repository);

  @override
  Future<Result<AppErrors, NewsOfCategoryEntity>> call(
      NewsSingleCategoryParam param) {
    return repository.getSingleNewsCategory(param);
  }
}
