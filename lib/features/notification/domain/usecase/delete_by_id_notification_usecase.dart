import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/notification/data/model/request/delete_notification.dart';
import 'package:starter_application/features/notification/domain/repository/inotification_repository.dart';

@injectable
class DeleteByIdNotificationUsecase
    extends UseCase<EmptyResponse, DeleteNotificationParams> {
  final INotificationRepository repository;

  DeleteByIdNotificationUsecase(this.repository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(DeleteNotificationParams param) {
    return repository.deleteNotificationById(param);
  }
}
