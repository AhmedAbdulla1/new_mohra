import 'package:starter_application/features/home_services/data/datasource/ihome_services_remote.dart';
import 'package:starter_application/features/home_services/domain/repository/ihome_services_repository.dart';

class HomeServicesRepository extends IHomeServicesRepository {
  final IHomeServicesRemoteSource iHomeServicesRemoteSource;

  HomeServicesRepository(this.iHomeServicesRemoteSource);


  // @override
  // Future<Result<AppErrors, BannersEntity>> getAllBanners(NoParams param) async{
  //   final remote = await iHomeRemoteSource.getAllBanners(param);
  //   return remote.result<BannersEntity>();
  // }

}
