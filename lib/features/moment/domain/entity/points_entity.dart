import 'package:starter_application/core/entities/base_entity.dart';

class PointsEntity extends BaseEntity{
  final ResultEntity? result;
  PointsEntity({this.result,});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ResultEntity extends BaseEntity{
  final int? points;
  ResultEntity(
      {this.points,
      });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}