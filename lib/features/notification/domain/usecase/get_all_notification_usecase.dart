import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import 'package:starter_application/features/notification/domain/entity/notification_entity.dart';
import 'package:starter_application/features/notification/domain/repository/inotification_repository.dart';

@injectable
class GetAllNotificationUsecase
    extends UseCase<NotificationResultEntity, GetAllNotificationParam> {
  final INotificationRepository repository;

  GetAllNotificationUsecase(this.repository);

  @override
  Future<Result<AppErrors, NotificationResultEntity>> call(GetAllNotificationParam param) {
    return repository.getAllNotification(param);
  }
}
