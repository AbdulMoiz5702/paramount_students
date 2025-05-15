import '../user_models/user_profile_model.dart';

class OTPResponse {
  final bool error;
  final int statusCode;
  final ResponseBody? responseBody;
  final String? message;

  OTPResponse({
    required this.error,
    required this.statusCode,
    this.responseBody,
    this.message,
  });

  factory OTPResponse.fromJson(Map<String, dynamic> json) {
    final rawResponse = json['responseBody'];

    if (rawResponse is Map<String, dynamic>) {
      return OTPResponse(
        error: json['error'] ?? false,
        statusCode: json['statusCode'] ?? 0,
        responseBody: ResponseBody.fromJson(rawResponse),
      );
    } else {
      return OTPResponse(
        error: json['error'] ?? false,
        statusCode: json['statusCode'] ?? 0,
        message: rawResponse?.toString(),
      );
    }
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