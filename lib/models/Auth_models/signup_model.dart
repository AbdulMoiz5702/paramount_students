
import '../user_models/user_OTP_data.dart';

class SignupRequestModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  SignupRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
    };
  }
}


class SignupResponseModel {
  final bool error;
  final int statusCode;
  final SignupResponseBody responseBody;

  SignupResponseModel({
    required this.error,
    required this.statusCode,
    required this.responseBody,
  });

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
      error: json['error'],
      statusCode: json['statusCode'],
      responseBody: SignupResponseBody.fromJson(json['responseBody']),
    );
  }
}





class SignupResponseBody {
  final String message;
  final UserOTPData userdata;

  SignupResponseBody({
    required this.message,
    required this.userdata,
  });

  factory SignupResponseBody.fromJson(Map<String, dynamic> json) {
    return SignupResponseBody(
      message: json['message'],
      userdata: UserOTPData.fromJson(json['userdata']),
    );
  }
}


