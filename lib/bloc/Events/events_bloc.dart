import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:paramount_student/Repositories/Events_Repo/Events_repo.dart';
import 'package:paramount_student/models/Events_models/Events_model.dart';
import '../../core/services/Shared_Preferences_Services/Shared_Preferences_Services.dart';
import 'events_event.dart';
import 'events_state.dart';


class EventsBloc extends HydratedBloc<EventsEvent, EventsState> {
  EventsBloc() : super(const EventsState(isAllEvents: false,allEvents: [],errorMessage: '',isSingleEvent: false,singleEvent: null)) {
    on<GetAllEvents>(getAllEvents);
    on<GetSingleEvent>(getSingleEvent);
  }





  Future<void> getAllEvents(GetAllEvents event, Emitter<EventsState> emit) async {
    try {
      emit(state.copyWith(isAllEvents: true));
      final EventsResponseModel responseModel = await EventsRepo.getAllEvents();
      final EventsResponseBody body = EventsResponseBody.fromJson(responseModel.responseBody.toJson());
      final List<EventsModel> allEvents = body.data;
      emit(state.copyWith(allEvents: allEvents, isAllEvents: false));
    } catch (error) {
      emit(state.copyWith(isAllEvents: false, errorMessage: error.toString()));
    }
  }


  Future<void> getSingleEvent(GetSingleEvent event, Emitter<EventsState> emit,) async {
    try {
      emit(state.copyWith(isSingleEvent: true));
      final currentEvent = await EventsRepo.getSingleEvent(id: event.id);
      final data = currentEvent.responseBody;
     // emit(state.copyWith(singleEvent: data, isSingleEvent: false));
    } catch (error) {
      emit(state.copyWith(isSingleEvent: false, errorMessage: error.toString()));
    }
  }

  @override
  EventsState? fromJson(Map<String, dynamic> json) {
    try {
      final List<dynamic> eventsJsonList = json[BlocKeys.eventsKey];
      final events = eventsJsonList.map((eventJson) => EventsModel.fromJson(eventJson)).toList();
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
    try {
      return {
        BlocKeys.eventsKey: state.allEvents.map((e) => e.toJson()).toList(),
      };
    } catch (_) {
      return null;
    }
  }


}
