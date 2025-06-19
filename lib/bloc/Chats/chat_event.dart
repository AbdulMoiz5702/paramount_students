import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../models/Chat_Models/Chat_messages_model.dart';

abstract class ChatEvent extends Equatable{
  @override
  List<Object> get props =>[];
}


class GetAllChats extends ChatEvent{}


class GetChatsMessages extends ChatEvent{
  final int id;
  GetChatsMessages({required this.id});
  @override
  List<Object> get props =>[id];
}


class SendChatsMessages extends ChatEvent{
  final int receiverId;
  final BuildContext context;
  SendChatsMessages({required this.receiverId,required this.context});
  @override
  List<Object> get props =>[receiverId,context];
}


class NewChatMessageReceived extends ChatEvent {
  final ChatMessage newMessage;
  NewChatMessageReceived({required this.newMessage});
}
