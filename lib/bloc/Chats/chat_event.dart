import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable{
  @override
  List<Object> get props =>[];
}


class GetAllChats extends ChatEvent{

}
