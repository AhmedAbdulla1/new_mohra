import 'package:injectable/injectable.dart';

import 'ihome_services_remote.dart';

@Injectable(as: IHomeServicesRemoteSource)
class HomeServicesRemoteSource extends IHomeServicesRemoteSource {
  // @override
  // Future<Either<AppErrors, BannersModel>> getAllBanners(NoParams param) {
  //   return request(
  //     converter: (json) => BannersModel.fromJson(json),
  //     method: HttpMethod.GET,
  //     url: APIUrls.getAllBanners,
  //   );
  // }

}
