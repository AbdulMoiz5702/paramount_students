

class AppApis {

  // images path
  static const String domainUrl = 'http://$_ip:8001';


  // Auth Apis
  static const String  _ip = '192.168.1545.1';
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
  static const String updateUserPic = '$_baseUrl/v1/users/upload-image/';


  // Organization Apis
  static const String getAllOrganizations = '$_baseUrl/v1/organizations';
  static const String getSingleOrganization = '$_baseUrl/v1/organizations/';
  static const String postOrganizations = '$_baseUrl/v1/organizations';
  static const String deleteOrganizations = '$_baseUrl/v1/organizations/';

  // Communities Apis
  static const String getAllCommunities = '$_baseUrl/v1/communities/all';
  static const String getSingleCommunities = '$_baseUrl/v1/communities/';

  // Events Apis
  static const String getAllEvents = '$_baseUrl/v1/events/all';
  static const String getSingleEvents = '$_baseUrl/v1/events/';

}