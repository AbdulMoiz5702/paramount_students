class ChatMessagesResponse {
  final bool error;
  final int statusCode;
  final ChatMessagesBody responseBody;

  ChatMessagesResponse({
    required this.error,
    required this.statusCode,
    required this.responseBody,
  });

  factory ChatMessagesResponse.fromJson(Map<String, dynamic> json) {
    return ChatMessagesResponse(
      error: json['error'],
      statusCode: json['statusCode'],
      responseBody: ChatMessagesBody.fromJson(json['responseBody']),
    );
  }

  Map<String, dynamic> toJson() => {
    'error': error,
    'statusCode': statusCode,
    'responseBody': responseBody.toJson(),
  };
}



class ChatMessagesBody {
  final int currentPage;
  final List<ChatMessage> data;
  final int from;
  final int lastPage;
  final String? nextPageUrl;
  final String? prevPageUrl;
  final int total;

  ChatMessagesBody({
    required this.currentPage,
    required this.data,
    required this.from,
    required this.lastPage,
    required this.nextPageUrl,
    required this.prevPageUrl,
    required this.total,
  });

  factory ChatMessagesBody.fromJson(Map<String, dynamic> json) {
    return ChatMessagesBody(
      currentPage: json['current_page'],
      data: List<ChatMessage>.from(json['data'].map((x) => ChatMessage.fromJson(x))),
      from: json['from'] ?? 0,
      lastPage: json['last_page'],
      nextPageUrl: json['next_page_url'],
      prevPageUrl: json['prev_page_url'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() => {
    'current_page': currentPage,
    'data': data.map((x) => x.toJson()).toList(),
    'from': from,
    'last_page': lastPage,
    'next_page_url': nextPageUrl,
    'prev_page_url': prevPageUrl,
    'total': total,
  };
}



class ChatMessage {
  final int id;
  final int senderId;
  final int receiverId;
  final String message;
  final String? replyTo;
  final String? mediaPath;
  final String? mediaType;
  final int isRead;
  final String? editedAt;
  final String? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ChatUser sender;
  final ChatUser receiver;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    this.replyTo,
    this.mediaPath,
    this.mediaType,
    required this.isRead,
    this.editedAt,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.sender,
    required this.receiver,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      message: json['message'],
      replyTo: json['reply_to'],
      mediaPath: json['media_path'],
      mediaType: json['media_type'],
      isRead: json['is_read'],
      editedAt: json['edited_at'],
      deletedAt: json['deleted_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      sender: ChatUser.fromJson(json['sender']),
      receiver: ChatUser.fromJson(json['receiver']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'sender_id': senderId,
    'receiver_id': receiverId,
    'message': message,
    'reply_to': replyTo,
    'media_path': mediaPath,
    'media_type': mediaType,
    'is_read': isRead,
    'edited_at': editedAt,
    'deleted_at': deletedAt,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'sender': sender.toJson(),
    'receiver': receiver.toJson(),
  };
}



class ChatUser {
  final int id;
  final String firstName;
  final String lastName;
  final String? username;
  final String email;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String gender;
  final int? universityId;
  final String? profilePicture;
  final String? interests;
  final String? googleSigninId;
  final String? googleExpire;
  final String? emailVerifiedAt;
  final bool active;
  final String? otp;
  final String? otpExpire;
  final String createdAt;
  final String updatedAt;

  ChatUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.username,
    required this.email,
    this.phoneNumber,
    this.dateOfBirth,
    required this.gender,
    this.universityId,
    this.profilePicture,
    this.interests,
    this.googleSigninId,
    this.googleExpire,
    this.emailVerifiedAt,
    required this.active,
    this.otp,
    this.otpExpire,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      universityId: json['university_id'],
      profilePicture: json['profile_picture'],
      interests: json['interests'],
      googleSigninId: json['google_signin_id'],
      googleExpire: json['google_expire'],
      emailVerifiedAt: json['email_verified_at'],
      active: json['active'] == 1,
      otp: json['otp'],
      otpExpire: json['otp_expire'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'username': username,
    'email': email,
    'phone_number': phoneNumber,
    'date_of_birth': dateOfBirth,
    'gender': gender,
    'university_id': universityId,
    'profile_picture': profilePicture,
    'interests': interests,
    'google_signin_id': googleSigninId,
    'google_expire': googleExpire,
    'email_verified_at': emailVerifiedAt,
    'active': active ? 1 : 0,
    'otp': otp,
    'otp_expire': otpExpire,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

