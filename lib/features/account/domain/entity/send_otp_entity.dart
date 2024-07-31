
import 'package:starter_application/core/entities/base_entity.dart';

class SendOtpEntity extends BaseEntity {
  SendOtpEntity({
    required this.result,
  });

  final  SendOtpEntityResult result;

  @override
  List<Object?> get props => [];
}

class SendOtpEntityResult extends BaseEntity{
  final  String? status;
  final  String? message;
  final  String? otp;
  SendOtpEntityResult({this.status, this.message, this.otp});

  @override
  List<Object?> get props => [
    status,
    message,
    otp
  ];
}
