




// todo implement this entity from api




import 'package:starter_application/core/entities/base_entity.dart';

class WeatherEntity extends BaseEntity {
  WeatherEntity({
    required this.data,
  });

  final WeatherDataEntity data;

  factory WeatherEntity.fromJson(dynamic json) {
    print('in entity'+json);
    return  WeatherEntity(
    data: WeatherDataEntity.fromJson(json["result"]),
  );}

  Map<String, dynamic> toJson() => {
    "result": data.toJson(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}


class WeatherDataEntity extends BaseEntity {
  WeatherDataEntity({
    required this.temperature,
    required this.condition,
  });

  final String? temperature;
  final String? condition;

  factory WeatherDataEntity.fromJson(Map<String, dynamic> json) => WeatherDataEntity(
    temperature: json["temperature"],
    condition: json["condition"],
  );

  Map<String, dynamic> toJson() => {
    "temperature": temperature,
    "condition": condition,
  };
  @override
  List<Object?> get props => [temperature,condition];
}