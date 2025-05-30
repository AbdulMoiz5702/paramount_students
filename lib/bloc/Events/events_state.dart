import 'package:equatable/equatable.dart';
import 'package:paramount_student/models/Events_models/Events_model.dart';

 class EventsState extends Equatable {
   final bool isAllEvents;
   final List<EventsResponseBody> allEvents;
   final EventsResponseBody ? singleEvent;
   final String errorMessage;
   final bool isSingleEvent;

   const EventsState({
     required this.isAllEvents,
     required this.allEvents,
     required this.errorMessage,
     required this.isSingleEvent,
     required this.singleEvent,
   });

   EventsState copyWith({
     bool? isAllEvents,
     List<EventsResponseBody>? allEvents,
     String? errorMessage,
     bool ? isSingleEvent,
     EventsResponseBody ? singleEvent
   }) {
     return EventsState(
       isAllEvents: isAllEvents ?? this.isAllEvents,
       allEvents: allEvents ?? this.allEvents,
       isSingleEvent: isSingleEvent ?? this.isSingleEvent,
       errorMessage: errorMessage ?? this.errorMessage,
       singleEvent: singleEvent ?? this.singleEvent
     );
   }

  @override
  List<Object?> get props => [isAllEvents,allEvents,errorMessage,isSingleEvent,singleEvent];
 }


