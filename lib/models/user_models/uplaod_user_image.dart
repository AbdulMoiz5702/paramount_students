
class UploadProfilePic {
  final bool error;
  final int statusCode;
  final String responseBody;

  UploadProfilePic({
    required this.error,
    required this.statusCode,
    required this.responseBody,
  });

  factory UploadProfilePic.fromJson(Map<String, dynamic> json) {
    return UploadProfilePic(
      error: json['error'] ?? true,
      statusCode: json['statusCode'] ?? 400,
      responseBody: json['responseBody'] ?? '',
    );
  }
}
