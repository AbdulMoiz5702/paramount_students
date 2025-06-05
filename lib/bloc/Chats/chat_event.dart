import 'package:equatable/equatable.dart';

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
