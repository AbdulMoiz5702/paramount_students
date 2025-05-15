import '../user_models/user_profile_model.dart';

class OTPResponse {
  final bool error;
  final int statusCode;
  final ResponseBody responseBody;

  OTPResponse({
    required this.error,
    required this.statusCode,
    required this.responseBody,
  });

  factory OTPResponse.fromJson(Map<String, dynamic> json) {
    return OTPResponse(
      error: json['error'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      responseBody: ResponseBody.fromJson(json['responseBody']),
    );
  }

}


class ResponseBody {
  final User user;
  final String accessToken;

  ResponseBody({
    required this.user,
    required this.accessToken,
  });

  factory ResponseBody.fromJson(Map<String, dynamic> json) {
    return ResponseBody(
      user: User.fromJson(json['user']),
      accessToken: json['accessToken'],
    );
  }

}