import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/account/domain/entity/send_otp_entity.dart';

SendOtpModel SendOtpModelFromMap(String str) =>
    SendOtpModel.fromMap(json.decode(str));

// String registerModelToMap(RegisterModel data) => json.encode(data.toMap());

class SendOtpModel extends BaseModel<SendOtpEntity> {
  SendOtpModel({
    required this.status,
    required this.message,
    required this.otp,
  });

  String status;
  String message;
  String otp;

  factory SendOtpModel.fromMap(Map<String, dynamic> json) {
    print(json);
    return SendOtpModel(
      status: json["status"]??"",
      message: json["message"].toString(),
      otp: json["otp"].toString()??'',
    );
  }
  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "otp": otp,
  };

  @override
  SendOtpEntity toEntity() {
    print(status);
    return SendOtpEntity(
      result: SendOtpEntityResult(
        status: status,
        message: message,
        otp: otp,
      ),
    );
  }
}
