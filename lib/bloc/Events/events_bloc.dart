import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:paramount_student/Repositories/Events_Repo/Events_repo.dart';
import 'package:paramount_student/models/Events_models/Events_model.dart';
import 'events_event.dart';
import 'events_state.dart';


class EventsBloc extends HydratedBloc<EventsEvent, EventsState> {
  EventsBloc() : super(const EventsState(isAllEvents: false,allEvents: [],errorMessage: '',isSingleEvent: false,singleEvent: null)) {
    on<GetAllEvents>(getAllEvents);
  }


  Future<void> getSingleEvent(GetSingleEvent event, Emitter<EventsState> emit,) async {
    try {
      emit(state.copyWith(isSingleEvent: true));
      final currentEvent = await EventsRepo.getSingleEvent(id: event.id);
      final data = currentEvent.responseBody;
      emit(state.copyWith(singleEvent: data, isSingleEvent: false));
    } catch (error) {
      emit(state.copyWith(isSingleEvent: false, errorMessage: error.toString()));
    }
  }


  Future<void> getAllEvents(GetAllEvents event, Emitter<EventsState> emit) async {
    try {
      emit(state.copyWith(isAllEvents: true));
      final List<EventsModel> eventModels = await EventsRepo.getAllEvents();
      final List<EventsResponseBody> allEvents = eventModels.map((e) => e.responseBody).toList();
      emit(state.copyWith(allEvents: allEvents, isAllEvents: false));
    } catch (error) {
      emit(state.copyWith(isAllEvents: false, errorMessage: error.toString()));
    }
  }

  @override
  EventsState? fromJson(Map<String, dynamic> json) {
    try {
      final List<dynamic> eventsJsonList = json['events'];
      final events = eventsJsonList.map((eventJson) => EventsResponseBody.fromJson(eventJson)).toList();
      return EventsState(
        isAllEvents: false,
        allEvents: events,
        isSingleEvent: false,
        errorMessage: '',
          singleEvent: null
      );
    } catch (_) {
      return null;
    }
  }


  @override
  Map<String, dynamic>? toJson(EventsState state) {
    throw UnimplementedError();
  }

}
