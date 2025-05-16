

import '../user_models/user_OTP_data.dart';

class ForgotPasswordResponse {
  final bool error;
  final int statusCode;
  final ResponseBody responseBody;

  ForgotPasswordResponse({
    required this.error,
    required this.statusCode,
    required this.responseBody,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      error: json['error'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      responseBody: ResponseBody.fromJson(json['responseBody']),
    );
  }
}


class ResponseBody {
  final UserOTPData userData;
  final String  message;

  ResponseBody({
   required this.userData,
    required this.message,
  });

  factory ResponseBody.fromJson(Map<String, dynamic> json) {
    return ResponseBody(
      userData:  UserOTPData.fromJson(json['userData']),
      message: json['0'],
    );
  }

}