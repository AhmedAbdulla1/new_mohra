import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/mylife/data/model/request/get_stories_request.dart';
import 'package:starter_application/features/mylife/domain/entity/story_entity.dart';
import 'package:starter_application/features/mylife/domain/repository/imylife_repository.dart';

@injectable
class GetStoriesUseCase
    extends UseCase<StoryEntity, GetStoryRequest> {
  IMylifeRepository _iMylifeRepository;

  GetStoriesUseCase(this._iMylifeRepository);

  @override
  Future<Result<AppErrors, StoryEntity>> call(
      GetStoryRequest param) async {
    return await _iMylifeRepository.getStories(param);
  }
}
