import 'package:starter_application/core/params/base_params.dart';

class VerifyOtpParams extends BaseParams{

  String phoneNumberWithCountryCode ;
  String otpCode ;

  VerifyOtpParams({
    required this.phoneNumberWithCountryCode,
    required this.otpCode,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'to' : phoneNumberWithCountryCode,
      'code' : otpCode,
    };
  }

  @override
  String toString() {
    return 'verify otp prarams {phone: $phoneNumberWithCountryCode, otp: $otpCode}';
  }
}