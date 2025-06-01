
import 'dart:convert';

class SingleEventsResponseModel {
  final bool error;
  final int statusCode;
  final SingleEventsResponseBody responseBody;

  SingleEventsResponseModel({
    required this.error,
    required this.statusCode,
    required this.responseBody,
  });

  factory SingleEventsResponseModel.fromJson(Map<String, dynamic> json) => SingleEventsResponseModel(
    error: json['error'],
    statusCode: json['statusCode'],
    responseBody: SingleEventsResponseBody.fromJson(json['responseBody']),
  );

  Map<String, dynamic> toJson() => {
    'error': error,
    'statusCode': statusCode,
    'responseBody': responseBody.toJson(),
  };
}

class SingleEventsResponseBody {
  final SingleEventModel eventData;
  final List<EventCommunity> eventCommunity;

  SingleEventsResponseBody({
    required this.eventData,
    required this.eventCommunity,
  });

  factory SingleEventsResponseBody.fromJson(Map<String, dynamic> json) => SingleEventsResponseBody(
    eventData: SingleEventModel.fromJson(json['eventData']),
    eventCommunity: (json['eventCommunity'] as List)
        .map((e) => EventCommunity.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'eventData': eventData.toJson(),
    'eventCommunity': eventCommunity.map((e) => e.toJson()).toList(),
  };
}

class SingleEventModel {
  final int id;
  final String eventName;
  final String eventDate;
  final String eventLocation;
  final String? country;
  final String? state;
  final String description;
  final String type;
  final String mode;
  final String latitude;
  final String longitude;
  final int price;
  final String ticketStartDate;
  final String ticketEndDate;
  final int slot;
  final int communityId;
  final int organizationId;
  final List<String> galleries;
  final String status;
  final bool isRescheduled;
  final String? rescheduledAt;
  final String createdAt;
  final String updatedAt;
  final String formattedEventDate;
  final String? city;
  final String? countryCode;
  final List<dynamic> moderators;
  final List<Member> members;
  final int sold;
  final String communityName;

  SingleEventModel({
    required this.id,
    required this.eventName,
    required this.eventDate,
    required this.eventLocation,
    this.country,
    this.state,
    required this.description,
    required this.type,
    required this.mode,
    required this.latitude,
    required this.longitude,
    required this.price,
    required this.ticketStartDate,
    required this.ticketEndDate,
    required this.slot,
    required this.communityId,
    required this.organizationId,
    required this.galleries,
    required this.status,
    required this.isRescheduled,
    this.rescheduledAt,
    required this.createdAt,
    required this.updatedAt,
    required this.formattedEventDate,
    this.city,
    this.countryCode,
    required this.moderators,
    required this.members,
    required this.sold,
    required this.communityName,
  });

  factory SingleEventModel.fromJson(Map<String, dynamic> json) {
    List<String> galleriesList = [];
    if (json['galleries'] is String) {
      galleriesList = List<String>.from(jsonDecode(json['galleries']));
    } else if (json['galleries'] is List) {
      galleriesList = List<String>.from(json['galleries']);
    }

    return SingleEventModel(
      id: json['id'],
      eventName: json['event_name'],
      eventDate: json['event_date'],
      eventLocation: json['event_location'],
      country: json['country'],
      state: json['state'],
      description: json['description'],
      type: json['type'],
      mode: json['mode'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      price: json['price'],
      ticketStartDate: json['ticket_start_date'],
      ticketEndDate: json['ticket_end_date'],
      slot: json['slot'],
      communityId: json['community_id'],
      organizationId: json['organization_id'],
      galleries: galleriesList,
      status: json['status'],
      isRescheduled: json['is_rescheduled'] == 1,
      rescheduledAt: json['rescheduled_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      formattedEventDate: json['formatted_event_date'],
      city: json['city'],
      countryCode: json['country_code'],
      moderators: json['moderators'] ?? [],
      members: (json['members'] as List)
          .map((e) => Member.fromJson(e))
          .toList(),
      sold: json['sold'],
      communityName: json['community_name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'event_name': eventName,
    'event_date': eventDate,
    'event_location': eventLocation,
    'country': country,
    'state': state,
    'description': description,
    'type': type,
    'mode': mode,
    'latitude': latitude,
    'longitude': longitude,
    'price': price,
    'ticket_start_date': ticketStartDate,
    'ticket_end_date': ticketEndDate,
    'slot': slot,
    'community_id': communityId,
    'organization_id': organizationId,
    'galleries': jsonEncode(galleries),
    'status': status,
    'is_rescheduled': isRescheduled ? 1 : 0,
    'rescheduled_at': rescheduledAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'formatted_event_date': formattedEventDate,
    'city': city,
    'country_code': countryCode,
    'moderators': moderators,
    'members': members.map((e) => e.toJson()).toList(),
    'sold': sold,
    'community_name': communityName,
  };
}

class Member {
  final int id;
  final int eventId;
  final int userId;
  final dynamic memberDetails; // null in example, keep dynamic

  Member({
    required this.id,
    required this.eventId,
    required this.userId,
    this.memberDetails,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    id: json['id'],
    eventId: json['event_id'],
    userId: json['user_id'],
    memberDetails: json['member_details'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'event_id': eventId,
    'user_id': userId,
    'member_details': memberDetails,
  };
}

class EventCommunity {
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

  EventCommunity({
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
  });

  factory EventCommunity.fromJson(Map<String, dynamic> json) {
    List<String> galleriesList = [];
    if (json['galleries'] is String) {
      galleriesList = List<String>.from(jsonDecode(json['galleries']));
    } else if (json['galleries'] is List) {
      galleriesList = List<String>.from(json['galleries']);
    }

    return EventCommunity(
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
  };
}
