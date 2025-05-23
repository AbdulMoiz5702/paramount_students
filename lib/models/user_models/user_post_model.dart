

class UserProfileModel {
  final bool error;
  final int statusCode;
  final UserPostBody responseBody;
  UserProfileModel({
    required this.error,
    required this.statusCode,
    required this.responseBody,
  });
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      error: json['error'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      responseBody: UserPostBody.fromJson(json['responseBody']),
    );
  }

}

class UserPostBody {
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

  UserPostBody({
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
  factory UserPostBody.fromJson(Map<String, dynamic> json) {
    return UserPostBody(
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
