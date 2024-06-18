import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/news/data/model/request/news_summery_param.dart';
import 'package:starter_application/features/news/domain/entity/news_summery_entity.dart';
import 'package:starter_application/features/news/domain/repository/inews_repository.dart';

@injectable
class GetSummeryNewsUsecase
    extends UseCase<SummryNewsEntity, NewsSummerParam> {
  final INewsRepository repository;

  GetSummeryNewsUsecase(this.repository);

  @override
  Future<Result<AppErrors, SummryNewsEntity>> call(NewsSummerParam param) {
    return repository.getSummeryNews(param);
  }
}
