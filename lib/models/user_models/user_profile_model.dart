


import 'package:paramount_student/core/helper_fuctions/current_access_token.dart';
import 'package:paramount_student/core/helper_fuctions/helper_function.dart';

class UserProfileModel {
  final bool error;
  final int statusCode;
  final User responseBody;

  UserProfileModel({
    required this.error,
    required this.statusCode,
    required this.responseBody,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      error: json['error'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      responseBody: User.fromJson(json['responseBody']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'statusCode': statusCode,
      'responseBody': responseBody.toJson(),
    };
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String? username;
  final String email;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String gender;
  final int? universityId;
  final String? profilePicture;
  final List<dynamic> interests;
  final String? googleSigninId;
  final String? googleExpire;
  final String? emailVerifiedAt;
  final int active;
  final String? otp;
  final String? otpExpire;
  final String createdAt;
  final String updatedAt;
  final UserDetail? userDetail;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.username,
    required this.email,
    this.phoneNumber,
    this.dateOfBirth,
    required this.gender,
    this.universityId,
    this.profilePicture,
    required this.interests,
    this.googleSigninId,
    this.googleExpire,
    this.emailVerifiedAt,
    required this.active,
    this.otp,
    this.otpExpire,
    required this.createdAt,
    required this.updatedAt,
    this.userDetail,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      universityId: json['university_id'],
      profilePicture: json['profile_picture'] != null ? HelperFunctions.getFullProfilePictureUrl(userId:int.parse(CurrentUserSecrets.currentUserId),imageUrl: json['profile_picture']):null,
      interests: List<dynamic>.from(json['interests'] ?? []),
      googleSigninId: json['google_signin_id'],
      googleExpire: json['google_expire'],
      emailVerifiedAt: json['email_verified_at'],
      active: json['active'],
      otp: json['otp'],
      otpExpire: json['otp_expire'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      userDetail: json['user_detail'] != null
          ? UserDetail.fromJson(json['user_detail'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'university_id': universityId,
      'profile_picture': profilePicture,
      'interests': interests,
      'google_signin_id': googleSigninId,
      'google_expire': googleExpire,
      'email_verified_at': emailVerifiedAt,
      'active': active,
      'otp': otp,
      'otp_expire': otpExpire,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user_detail': userDetail?.toJson(),
    };
  }
}

class UserDetail {
  final int id;
  final int userId;
  final String universityName;
  final String universityLocation;
  final String city;
  final String dateOfBirth;
  final String gender;
  final String country;
  final String courseOfStudy;
  final String createdAt;
  final String updatedAt;

  UserDetail({
    required this.id,
    required this.userId,
    required this.universityName,
    required this.universityLocation,
    required this.city,
    required this.dateOfBirth,
    required this.gender,
    required this.country,
    required this.courseOfStudy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      id: json['id'],
      userId: json['user_id'],
      universityName: json['university_name'],
      universityLocation: json['university_location'],
      city: json['city'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      country: json['country'],
      courseOfStudy: json['course_of_study'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'university_name': universityName,
      'university_location': universityLocation,
      'city': city,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'country': country,
      'course_of_study': courseOfStudy,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
