import 'package:equatable/equatable.dart';
import 'package:paramount_student/models/Events_models/Events_model.dart';

 class EventsState extends Equatable {
   final bool isAllEvents;
   final List<EventsModel> allEvents;
   final EventsModel ? singleEvent;
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
     List<EventsModel>? allEvents,
     String? errorMessage,
     bool ? isSingleEvent,
     EventsModel ? singleEvent
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


extension EventsStateExtension on EventsState {
  List<EventsModel> get allEventsModels => allEvents;
}




