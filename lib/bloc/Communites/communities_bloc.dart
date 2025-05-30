import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:paramount_student/models/Communities_models/Communities_model.dart';

import 'communities_event.dart';
import 'communities_state.dart';


class CommunitiesBloc extends HydratedBloc<CommunitiesEvent, CommunitiesState> {
  CommunitiesBloc() : super(const CommunitiesState(isAllCommunities: false,allCommunities: [],errorMessage: '',isSingleCommunities: false,singleCommunities: null)) {
    on<CommunitiesEvent>();
  }




  @override
  CommunitiesState? fromJson(Map<String, dynamic> json) {
    try {
      final List<dynamic> eventsJsonList = json['events'];
      final events = eventsJsonList.map((eventJson) => CommunitiesResponseModel.fromJson(eventJson)).toList();
      return CommunitiesState(
          isAllCommunities: false,
          allCommunities: events,
          isSingleCommunities: false,
          errorMessage: '',
          singleCommunities: null
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(state) {
    throw UnimplementedError();
  }
}
