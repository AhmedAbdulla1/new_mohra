import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/notification/domain/repository/inotification_repository.dart';

@injectable
class DeleteAllNotificationUsecase
    extends UseCase<EmptyResponse, NoParams> {
  final INotificationRepository repository;

  DeleteAllNotificationUsecase(this.repository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(NoParams param) {
    return repository.deleteAllMyNotification(param);
  }
}
