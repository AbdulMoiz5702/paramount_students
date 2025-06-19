// ignore_for_file: unrelated_type_equality_checks
import 'package:flutter/material.dart';
import '../../../../models/Chat_Models/Chat_messages_model.dart';

class ChatBubbleWidget extends StatelessWidget {
  const ChatBubbleWidget({
    super.key,
    required this.messages,
    required this.currentUserId,
  });

  final ChatMessage messages;
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: messages.senderId == currentUserId? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: const EdgeInsets.symmetric(vertical: 6),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: messages.senderId == currentUserId ? Colors.blueAccent.withOpacity(0.8) : Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: messages.senderId == currentUserId
                ? const Radius.circular(18)
                : const Radius.circular(0),
            bottomRight: messages.senderId == currentUserId
                ? const Radius.circular(0)
                : const Radius.circular(18),
          ),
        ),
        child: Text(
          messages.message,
          style: TextStyle(
            color: messages.senderId == currentUserId ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}