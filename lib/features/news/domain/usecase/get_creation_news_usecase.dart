import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/news/data/model/request/news_sorting_request.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/news/domain/repository/inews_repository.dart';

@injectable
class GetCreationTimeNewsUsecase
    extends UseCase<NewsOfCategoryEntity, NewsSortParam> {
  final INewsRepository repository;

  GetCreationTimeNewsUsecase(this.repository);

  @override
  Future<Result<AppErrors, NewsOfCategoryEntity>> call(NewsSortParam param) {
    return repository.getCreationTimeNews(param);
  }
}
