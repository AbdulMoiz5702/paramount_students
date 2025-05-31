import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:paramount_student/Repositories/Communities_Repo/Communites_repo.dart';
import 'package:paramount_student/core/services/Shared_Preferences_Services/Shared_Preferences_Services.dart';
import 'package:paramount_student/models/Communities_models/Communities_model.dart';
import 'communities_event.dart';
import 'communities_state.dart';


class CommunitiesBloc extends HydratedBloc<CommunitiesEvent, CommunitiesState> {
  CommunitiesBloc() : super(const CommunitiesState(isAllCommunities: false,allCommunities: [],errorMessage: '',isSingleCommunities: false,singleCommunities: null)) {
    on<GetSingleCommunities>(getSingleCommunities);
    on<GetAllCommunities>(getAllCommunities);
  }




  Future<void> getAllCommunities(GetAllCommunities event, Emitter<CommunitiesState> emit) async {
    try {
      emit(state.copyWith(isAllCommunities: true));
      final CommunitiesResponseModel responseModel = await CommunitiesRepo.getAllCommunities();
      final CommunitiesResponseBody body = responseModel.responseBody;
      final List<CommunityModel> allCommunities = body.data;
      emit(state.copyWith(allCommunities: allCommunities, isAllCommunities: false));
    } catch (error) {
      emit(state.copyWith(isAllCommunities: false, errorMessage: error.toString()));
    }
  }


  Future<void> getSingleCommunities(GetSingleCommunities event, Emitter<CommunitiesState> emit,) async {
    try {
      emit(state.copyWith(isSingleCommunities: true));
      final currentEvent = await CommunitiesRepo.getSingleCommunities(id: event.id);
      final data = currentEvent.responseBody;
      emit(state.copyWith(singleCommunities: data, isSingleCommunities: false));
    } catch (error) {
      emit(state.copyWith(isSingleCommunities: false, errorMessage: error.toString()));
    }
  }



  @override
  CommunitiesState? fromJson(Map<String, dynamic> json) {
    try {
      final List<dynamic> eventsJsonList = json[BlocKeys.communitiesKey];
      final events = eventsJsonList.map((eventJson) => CommunityModel.fromJson(eventJson)).toList();
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
  Map<String, dynamic>? toJson(CommunitiesState state) {
    try {
      return {
        BlocKeys.communitiesKey: state.allCommunities.map((e) => e.toJson()).toList(),
      };
    } catch (_) {
      return null;
    }
  }

}
