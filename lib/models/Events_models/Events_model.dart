

import 'dart:convert';


class EventsModel {
  final bool error;
  final int statusCode;
  final EventsResponseBody responseBody;

  EventsModel({
    required this.error,
    required this.statusCode,
    required this.responseBody,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    return EventsModel(
      error: json['error'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      responseBody: EventsResponseBody.fromJson(json['responseBody']),
    );
  }
}

class EventsResponseBody {
  final int id;
  final String eventName;
  final String eventDate;
  final String eventLocation;
  final String? country;
  final String state;
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
  final List<Moderator> moderators;
  final List<Member> members;
  final int sold;
  final String communityName;

  EventsResponseBody({
    required this.id,
    required this.eventName,
    required this.eventDate,
    required this.eventLocation,
    this.country,
    required this.state,
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

  factory EventsResponseBody.fromJson(Map<String, dynamic> json) {
    return EventsResponseBody(
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
      galleries: List<String>.from(jsonDecode(json['galleries'])),
      status: json['status'],
      isRescheduled: json['is_rescheduled'] == 1,
      rescheduledAt: json['rescheduled_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      formattedEventDate: json['formatted_event_date'],
      city: json['city'],
      countryCode: json['country_code'],
      moderators: (json['moderators'] as List).map((e) => Moderator.fromJson(e)).toList(),
      members: (json['members'] as List).map((e) => Member.fromJson(e)).toList(),
      sold: json['sold'],
      communityName: json['community_name'],
    );
  }
}


class Member {
  final int id;
  final int eventId;
  final int userId;
  final dynamic memberDetails;

  Member({
    required this.id,
    required this.eventId,
    required this.userId,
    this.memberDetails,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      eventId: json['event_id'],
      userId: json['user_id'],
      memberDetails: json['member_details'],
    );
  }
}

class Moderator {
  Moderator();
  factory Moderator.fromJson(Map<String, dynamic> json) {
    return Moderator(); // Placeholder
  }
}

