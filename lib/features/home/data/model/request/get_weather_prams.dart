import 'package:starter_application/core/params/base_params.dart';

class  GetWeatherParams extends BaseParams {
  String lat;
  String lon;
  GetWeatherParams({required this.lat,required this.lon});

  @override
  Map<String, dynamic> toMap() {
    return {
      "Longitude": lon,
      "Latitude": lat
    };
  }
}