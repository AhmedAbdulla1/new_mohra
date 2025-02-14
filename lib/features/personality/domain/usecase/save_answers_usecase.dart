import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/personality/data/model/request/personalityAnswers.dart';
import 'package:starter_application/features/personality/domain/repository/ipersonality_repository.dart';

@singleton
class SaveAnswersUsecase extends UseCase<EmptyResponse, SavePersonaliityAnswers> {
  final IPersonalityRepository iPersonalityRepository;

  SaveAnswersUsecase(this.iPersonalityRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(SavePersonaliityAnswers param) {
    return iPersonalityRepository.saveAnswers(param);
  }
}