import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

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
