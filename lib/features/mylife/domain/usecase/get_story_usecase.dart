import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/mylife/data/model/request/get_story_params.dart';
import 'package:starter_application/features/mylife/domain/entity/story_entity.dart';
import 'package:starter_application/features/mylife/domain/repository/imylife_repository.dart';

@injectable
class GetStoryUseCase
    extends UseCase<StoryItemEntity, GetStoryParams> {
  IMylifeRepository _iMylifeRepository;

  GetStoryUseCase(this._iMylifeRepository);

  @override
  Future<Result<AppErrors, StoryItemEntity>> call(
      GetStoryParams param) async {
    return await _iMylifeRepository.getStory(param);
  }
}
