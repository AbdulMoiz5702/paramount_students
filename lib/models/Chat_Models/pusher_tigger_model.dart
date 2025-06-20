
class PusherTriggerMessageModel {
  final String message;
  final String senderId;
  final String receiverId;
  final String timestamp;

  PusherTriggerMessageModel({
    required this.message,
    required this.senderId,
    required this.receiverId,
    String? timestamp,
  }) : timestamp = timestamp ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': timestamp,
    };
  }

  factory PusherTriggerMessageModel.fromJson(Map<String, dynamic> json) {
    return PusherTriggerMessageModel(
      message: json['message'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      timestamp: json['timestamp'],
    );
  }
}
