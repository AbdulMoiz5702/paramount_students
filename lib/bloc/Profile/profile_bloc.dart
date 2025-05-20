import 'package:bloc/bloc.dart';
import 'package:paramount_student/core/exceptions/net_work_excptions.dart';
import '../../Repositories/Profile_repo/profile_repo.dart';
import '../../models/user_models/user_profile_model.dart';
import 'profile_event.dart';
import 'profile_state.dart';


import 'package:hydrated_bloc/hydrated_bloc.dart';

class ProfileBloc extends HydratedBloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState(user: null,onGetUser: false,errorMessage: '')) {
    on<GetCurrentUser>(getCurrentUser);
  }

  Future<void> getCurrentUser(GetCurrentUser event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(onGetUser: true));
      final userProfile = await ProfileRepo.getCurrentUser(id: event.id);
      final user = userProfile.responseBody;
      emit(state.copyWith(user: user, onGetUser: false));
    } catch (error) {
      emit(state.copyWith(onGetUser: false, errorMessage: error.toString()));
    }
  }

  @override
  ProfileState? fromJson(Map<String, dynamic> json) {
    try {
      return ProfileState(user: User.fromJson(json['user']),onGetUser: false,errorMessage: '');
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(ProfileState state) {
    try {
      if (state.user == null) return null;
      return {'user': state.user!.toJson()};
    } catch (_) {
      return null;
    }
  }
}

