import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/friend/domain/entity/get_count_frineds_and_notifications_entity.dart';
import 'package:starter_application/features/friend/domain/repository/ifriend_repository.dart';
@injectable
class GetCountFriendsAndNotifications
    extends UseCase<GetCountFrinedsAndNotificationsEntity, NoParams> {
  final IFriendRepository repository;

  GetCountFriendsAndNotifications(this.repository);
  @override
  Future<Result<AppErrors, GetCountFrinedsAndNotificationsEntity>> call(NoParams param) {
    return repository.getCountFriendsAndNotifications(param);
  }
}
