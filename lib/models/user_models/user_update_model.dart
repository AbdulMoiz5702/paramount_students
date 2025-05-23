

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
  String firstName;
  String lastName;
  String phoneNumber;
  String universityName;
  String universityLocation;
  String city;
  String dateOfBirth;
  String gender;
  String country;
  String courseOfStudy;

  UserUpdateBody({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.universityName,
    required this.universityLocation,
    required this.city,
    required this.dateOfBirth,
    required this.gender,
    required this.country,
    required this.courseOfStudy,
  });

  // Convert from JSON
  factory UserUpdateBody.fromJson(Map<String, dynamic> json) {
    return UserUpdateBody(
      firstName: json["first_name"],
      lastName: json["last_name"],
      phoneNumber: json["phone_number"],
      universityName: json["university_name"],
      universityLocation: json["university_location"],
      city: json["city"],
      dateOfBirth: json["date_of_birth"],
      gender: json["gender"],
      country: json["country"],
      courseOfStudy: json["course_of_study"],
    );
  }

  // Convert to JSON
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
