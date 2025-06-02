

class FollowUnFollowCommunityResponse {
  final bool error;
  final int statusCode;
  final String responseBody;

  FollowUnFollowCommunityResponse({
    required this.error,
    required this.statusCode,
    required this.responseBody,
  });

  factory FollowUnFollowCommunityResponse.fromJson(Map<String, dynamic> json) {
    return FollowUnFollowCommunityResponse(
      error: json['error'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      responseBody: json['responseBody'] ?? '',
    );
  }
}
