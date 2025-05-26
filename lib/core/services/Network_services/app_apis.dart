

class AppApis {

  // Auth Apis
  static const String  _ip = '192.168.1.124';
  static const String _baseUrl = 'http://$_ip:8001/api';
  static const String signup = '$_baseUrl/auth/signup';
  static const String login = '$_baseUrl/auth/login';
  static const String confirmOtp = '$_baseUrl/auth/confirm_otp?';
  static const String resendOtp = '$_baseUrl/auth/resend_otp?username=';
  static const String forgotPassword = '$_baseUrl/auth/forgot_password?username=';

// Users Apis
  static const String getUsers = '$_baseUrl/v1/users';
  static const String getSingleUser = '$_baseUrl/v1/users/';
  static const String updateCurrentUser = '$_baseUrl/v1/users/update/';

}