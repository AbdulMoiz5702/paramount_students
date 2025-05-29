


import 'package:equatable/equatable.dart';
import 'package:paramount_student/models/Events_models/Events_model.dart';

 class EventsState extends Equatable {
   final bool isAllEvents;
   final List<EventsResponseBody> events;
   final String errorMessage;

   const EventsState({
     required this.isAllEvents,
     required this.events,
     required this.errorMessage,
   });

   EventsState copyWith({
     bool? isAllEvents,
     List<EventsResponseBody>? events,
     String? errorMessage,
   }) {
     return EventsState(
       isAllEvents: isAllEvents ?? this.isAllEvents,
       events: events ?? this.events,
       errorMessage: errorMessage ?? this.errorMessage,
     );
   }

  @override
  List<Object?> get props => [isAllEvents,events,errorMessage];
 }


