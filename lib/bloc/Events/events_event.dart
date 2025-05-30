
import 'package:equatable/equatable.dart';

abstract class EventsEvent  extends Equatable{
  @override
  List<Object> get props => [];
}


class GetAllEvents extends EventsEvent {}

class GetSingleEvent extends EventsEvent {
  final int id;
  GetSingleEvent({required this.id});
  @override
  List<Object> get props => [id];
}
