import 'package:bloc/bloc.dart';
import '../../Repositories/Profile_repo/profile_repo.dart';
import '../../models/user_models/user_profile_model.dart';
import 'profile_event.dart';
import 'profile_state.dart';


import 'package:hydrated_bloc/hydrated_bloc.dart';

class ProfileBloc extends HydratedBloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState(user: null,onGetUser: false)) {
    on<GetCurrentUser>(getCurrentUser);
  }

  Future<void> getCurrentUser(GetCurrentUser event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(onGetUser: true));
      final user = await ProfileRepo.getCurrentUser(id: event.id);
      emit(state.copyWith(user: user,onGetUser: false));
    } catch (e) {
      emit(state.copyWith(onGetUser: false));
    }
  }

  @override
  ProfileState? fromJson(Map<String, dynamic> json) {
    try {
      return ProfileState(user: User.fromJson(json['user']),onGetUser: false);
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

