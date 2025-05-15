

class UserOTPData {
  final int id;
  final int otp;

  UserOTPData({
    required this.id,
    required this.otp,
  });

  factory UserOTPData.fromJson(Map<String, dynamic> json) {
    return UserOTPData(
      id: json['id'],
      otp: json['otp'],
    );
  }

}