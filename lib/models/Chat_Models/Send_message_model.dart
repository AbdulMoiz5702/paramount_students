

class SendMessageRequest {
  final String? message;
  final String? replyTo;

  SendMessageRequest({
    this.message,
    this.replyTo,
  });


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (message != null) data['message'] = message;
    if (replyTo != null) data['reply_to'] = replyTo;
    return data;
  }
}




class SendMessageResponse {
  final bool error;
  final int statusCode;
  final String responseBody;

  SendMessageResponse({
    required this.error,
    required this.statusCode,
    required this.responseBody,
  });

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) {
    return SendMessageResponse(
      error: json['error'] as bool,
      statusCode: json['statusCode'] as int,
      responseBody: json['responseBody'] as String,
    );
  }
}

