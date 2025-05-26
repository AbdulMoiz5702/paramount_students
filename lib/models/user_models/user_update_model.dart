
class UserUpdateModel {
  final bool error;
  final int statusCode;
  final UserUpdateBody responseBody;

  UserUpdateModel({
    required this.error,
    required this.statusCode,
    required this.responseBody,
  });

  factory UserUpdateModel.fromJson(Map<String, dynamic> json) {
    return UserUpdateModel(
      error: json['error'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      responseBody: UserUpdateBody.fromJson(json['responseBody']),
    );
  }
}

class UserUpdateBody {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? universityName;
  String? universityLocation;
  String? city;
  String? dateOfBirth;
  String? gender;
  String? country;
  String? courseOfStudy;

  UserUpdateBody({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.universityName,
    this.universityLocation,
    this.city,
    this.dateOfBirth,
    this.gender,
    this.country,
    this.courseOfStudy,
  });

  factory UserUpdateBody.fromJson(Map<String, dynamic> json) {
    final userDetail = json['user_detail'] ?? {};

    return UserUpdateBody(
      firstName: json["first_name"],
      lastName: json["last_name"],
      phoneNumber: json["phone_number"],
      universityName: userDetail["university_name"],
      universityLocation: userDetail["university_location"],
      city: userDetail["city"],
      dateOfBirth: json["date_of_birth"],
      gender: json["gender"],
      country: userDetail["country"],
      courseOfStudy: userDetail["course_of_study"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phoneNumber,
      "university_name": universityName,
      "university_location": universityLocation,
      "city": city,
      "date_of_birth": dateOfBirth,
      "gender": gender,
      "country": country,
      "course_of_study": courseOfStudy,
    };
  }
}

