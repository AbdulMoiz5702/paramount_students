

import 'dart:convert';

import 'dart:convert';

class SingleCommunityResponseModel {
  final bool error;
  final int statusCode;
  final SingleCommunityModel responseBody;

  SingleCommunityResponseModel({
    required this.error,
    required this.statusCode,
    required this.responseBody,
  });

  factory SingleCommunityResponseModel.fromJson(Map<String, dynamic> json) =>
      SingleCommunityResponseModel(
        error: json['error'],
        statusCode: json['statusCode'],
        responseBody: SingleCommunityModel.fromJson(json['responseBody']),
      );

  Map<String, dynamic> toJson() => {
    'error': error,
    'statusCode': statusCode,
    'responseBody': responseBody.toJson(),
  };
}

class SingleCommunityModel {
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
  final String createdAt;
  final String updatedAt;
  final int numberOfFollowers;
  final List<Follower> followers;
  final List<Interest> interests;
  final List<Moderator> moderators;
  final List<Announcement> announcements;

  SingleCommunityModel({
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
    required this.numberOfFollowers,
    required this.followers,
    required this.interests,
    required this.moderators,
    required this.announcements,
  });

  factory SingleCommunityModel.fromJson(Map<String, dynamic> json) {
    List<String> galleriesList = [];
    if (json['galleries'] is String) {
      galleriesList = List<String>.from(jsonDecode(json['galleries']));
    } else if (json['galleries'] is List) {
      galleriesList = List<String>.from(json['galleries']);
    }

    return SingleCommunityModel(
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
      galleries: galleriesList,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      numberOfFollowers: json['Number_of_Followers'] ?? 0,
      followers: (json['followers'] as List?)?.map((e) => Follower.fromJson(e)).toList() ?? [],
      interests: (json['interests'] as List).map((e) => Interest.fromJson(e)).toList(),
      moderators: (json['moderators'] as List).map((e) => Moderator.fromJson(e)).toList(),
      announcements: (json['announcements'] as List).map((e) => Announcement.fromJson(e)).toList(),
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
    'created_at': createdAt,
    'updated_at': updatedAt,
    'Number_of_Followers': numberOfFollowers,
    'followers': followers.map((e) => e.toJson()).toList(),
    'interests': interests.map((e) => e.toJson()).toList(),
    'moderators': moderators.map((e) => e.toJson()).toList(),
    'announcements': announcements.map((e) => e.toJson()).toList(),
  };
}

class Follower {
  final int id;
  final String firstName;
  final String lastName;
  final String profilePicture;
  final String createdAt;
  final FollowerPivot pivot;

  Follower({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
    required this.createdAt,
    required this.pivot,
  });

  factory Follower.fromJson(Map<String, dynamic> json) => Follower(
    id: json['id'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    profilePicture: json['profile_picture'],
    createdAt: json['created_at'],
    pivot: FollowerPivot.fromJson(json['pivot']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'profile_picture': profilePicture,
    'created_at': createdAt,
    'pivot': pivot.toJson(),
  };
}

class FollowerPivot {
  final int communityId;
  final int userId;

  FollowerPivot({
    required this.communityId,
    required this.userId,
  });

  factory FollowerPivot.fromJson(Map<String, dynamic> json) => FollowerPivot(
    communityId: json['community_id'],
    userId: json['user_id'],
  );

  Map<String, dynamic> toJson() => {
    'community_id': communityId,
    'user_id': userId,
  };
}

class Interest {
  final int interestId;
  final String name;
  final Pivot pivot;

  Interest({
    required this.interestId,
    required this.name,
    required this.pivot,
  });

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
    interestId: json['interest_id'],
    name: json['name'],
    pivot: Pivot.fromJson(json['pivot']),
  );

  Map<String, dynamic> toJson() => {
    'interest_id': interestId,
    'name': name,
    'pivot': pivot.toJson(),
  };
}

class Pivot {
  final int communityId;
  final int interestId;

  Pivot({
    required this.communityId,
    required this.interestId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    communityId: json['community_id'],
    interestId: json['interest_id'],
  );

  Map<String, dynamic> toJson() => {
    'community_id': communityId,
    'interest_id': interestId,
  };
}

class Moderator {
  final String name;

  Moderator({required this.name});

  factory Moderator.fromJson(Map<String, dynamic> json) => Moderator(
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
  };
}

class Announcement {
  final String title;
  final String description;
  Announcement({required this.title, required this.description});
  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
    title: json['title'],
    description: json['description'],
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
  };
}



