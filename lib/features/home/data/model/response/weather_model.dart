import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/home/domain/entity/weather_entity.dart';

WeatherModel weatherFromJson(String str) =>
    WeatherModel.fromJson(json.decode(str));

String weatherToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel extends BaseModel<WeatherEntity> {
  WeatherModel({
    required this.data,
  });

  final WeatherDataModel data;

  factory WeatherModel.fromJson(dynamic data) {
    return WeatherModel(
      data: WeatherDataModel.fromJson(data["result"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": data.toJson(),
      };

  @override
  WeatherEntity toEntity() {
   return WeatherEntity(
      data: data.toEntity(),
      // WeatherDataEntity(
      //   condition: data.condition,
      //   temperature: data.temperature,
      // ),
    );
  }
}

class WeatherDataModel extends BaseModel<WeatherDataEntity> {
  WeatherDataModel({
    required this.temperature,
    required this.condition,
  });

  final String? temperature;
  final String? condition;

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDataModel(
      temperature: json["temperature"],
      condition: json["condition"],
    );
  }

  Map<String, dynamic> toJson() => {
        "temperature": temperature,
        "condition": condition,
      };

  @override
  WeatherDataEntity toEntity() {
    return WeatherDataEntity(
      condition: condition,
      temperature: temperature,
    );
  }
}
