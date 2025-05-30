import 'dart:convert';

class CommunitiesResponseModel {
  final bool error;
  final int statusCode;
  final CommunitiesResponseBody responseBody;

  CommunitiesResponseModel({
    required this.error,
    required this.statusCode,
    required this.responseBody,
  });

  factory CommunitiesResponseModel.fromJson(Map<String, dynamic> json) {
    return CommunitiesResponseModel(
      error: json['error'],
      statusCode: json['statusCode'],
      responseBody: CommunitiesResponseBody.fromJson(json['responseBody']),
    );
  }

  Map<String, dynamic> toJson() => {
    'error': error,
    'statusCode': statusCode,
    'responseBody': responseBody.toJson(),
  };
}

class CommunitiesResponseBody {
  final int currentPage;
  final List<CommunityModel> data;

  CommunitiesResponseBody({
    required this.currentPage,
    required this.data,
  });

  factory CommunitiesResponseBody.fromJson(Map<String, dynamic> json) {
    return CommunitiesResponseBody(
      currentPage: json['current_page'],
      data: List<CommunityModel>.from(
        json['data'].map((item) => CommunityModel.fromJson(item)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'current_page': currentPage,
    'data': data.map((e) => e.toJson()).toList(),
  };
}

class CommunityModel {
  final int id;
  final String name;
  final String description;
  final String type;
  final String country;
  final String city;
  final String tiktokLink;
  final String instagramLink;
  final String youtubeLink;
  final String logoUrl;
  final String coverPhotoUrl;
  final List<String> galleries;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<dynamic> followers;

  CommunityModel({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.country,
    required this.city,
    required this.tiktokLink,
    required this.instagramLink,
    required this.youtubeLink,
    required this.logoUrl,
    required this.coverPhotoUrl,
    required this.galleries,
    required this.createdAt,
    required this.updatedAt,
    required this.followers,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      country: json['country'],
      city: json['city'],
      tiktokLink: json['tiktok_link'],
      instagramLink: json['instagram_link'],
      youtubeLink: json['youtube_link'],
      logoUrl: json['logo_url'],
      coverPhotoUrl: json['cover_photo_url'],
      galleries: List<String>.from(jsonDecode(json['galleries'])),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      followers: json['followers'], // You can strongly type this if you have follower data
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'type': type,
    'country': country,
    'city': city,
    'tiktok_link': tiktokLink,
    'instagram_link': instagramLink,
    'youtube_link': youtubeLink,
    'logo_url': logoUrl,
    'cover_photo_url': coverPhotoUrl,
    'galleries': jsonEncode(galleries),
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'followers': followers,
  };
}
