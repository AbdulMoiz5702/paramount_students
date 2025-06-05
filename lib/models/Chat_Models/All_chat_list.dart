class ChatListResponse {
  final bool error;
  final int statusCode;
  final List<ChatMessageBody> responseBody;

  ChatListResponse({
    required this.error,
    required this.statusCode,
    required this.responseBody,
  });

  factory ChatListResponse.fromJson(Map<String, dynamic> json) {
    return ChatListResponse(
      error: json['error'],
      statusCode: json['statusCode'],
      responseBody: (json['responseBody'] as List)
          .map((e) => ChatMessageBody.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'error': error,
    'statusCode': statusCode,
    'responseBody': responseBody.map((e) => e.toJson()).toList(),
  };
}


class ChatMessageBody {
  final ChatPartner chatPartner;
  final String message;
  final DateTime createdAt;
  final int senderId;
  final int receiverId;
  final int isRead;

  ChatMessageBody({
    required this.chatPartner,
    required this.message,
    required this.createdAt,
    required this.senderId,
    required this.receiverId,
    required this.isRead,
  });

  factory ChatMessageBody.fromJson(Map<String, dynamic> json) => ChatMessageBody(
    chatPartner: ChatPartner.fromJson(json['chat_partner']),
    message: json['message'],
    createdAt: DateTime.parse(json['created_at']),
    senderId: json['sender_id'],
    receiverId: json['receiver_id'],
    isRead: json['is_read'],
  );

  Map<String, dynamic> toJson() => {
    'chat_partner': chatPartner.toJson(),
    'message': message,
    'created_at': createdAt.toIso8601String(),
    'sender_id': senderId,
    'receiver_id': receiverId,
    'is_read': isRead,
  };
}


class ChatPartner {
  final int id;
  final String name;
  final String email;
  final String? profilePicture;

  ChatPartner({
    required this.id,
    required this.name,
    required this.email,
    this.profilePicture,
  });

  factory ChatPartner.fromJson(Map<String, dynamic> json) => ChatPartner(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    profilePicture: json['profile_picture'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'profile_picture': profilePicture,
  };
}
