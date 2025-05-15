

import '../user_models/user_OTP_data.dart';
import '../user_models/user_profile_model.dart';

class LoginRequestModel {
  final String email;
  final String password;
  LoginRequestModel({
    required this.email,
    required this.password,
  });
  Map<String, dynamic> toJson() {
    return {
      'username': email,
      'password': password,
    };
  }
}

class LoginResponse {
  final bool error;
  final int statusCode;
  final ResponseBody responseBody;

  LoginResponse({
    required this.error,
    required this.statusCode,
    required this.responseBody,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      error: json['error'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      responseBody: ResponseBody.fromJson(json['responseBody']),
    );
  }

}


class ResponseBody {
  final User? user;
  final String? accessToken;
  final UserOTPData? userData;
  final String? message;

  ResponseBody({
    this.user,
    this.accessToken,
    this.userData,
    this.message,
  });

  factory ResponseBody.fromJson(Map<String, dynamic> json) {
    return ResponseBody(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      accessToken: json['accessToken'],
      userData: json['userData'] != null ? UserOTPData.fromJson(json['userData']) : null,
      message: json['message'],
    );
  }

}



