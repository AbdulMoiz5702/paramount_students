import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:paramount_student/core/helper_fuctions/helper_function.dart';
import 'package:paramount_student/core/helper_fuctions/snack_bar.dart';
import 'package:paramount_student/models/user_models/user_update_model.dart';
import '../../Repositories/Profile_repo/profile_repo.dart';
import '../../core/services/Shared_Preferences_Services/Shared_Preferences_Services.dart';
import '../../models/user_models/user_profile_model.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ProfileBloc extends HydratedBloc<ProfileEvent, ProfileState> {
  ProfileBloc()
    : super(
        ProfileState(
          user: null,
          onGetUser: false,
          errorMessage: '',
          isUserUpdate: false,
          image: null,
        ),
      ) {
    on<GetCurrentUser>(getCurrentUser);
    on<UpdateCurrentUser>(updateCurrentUser);
    on<UploadUserProfilePic>(uploadUserProfilePic);
    on<PickUserProfilePic>(pickUserProfilePic);
  }

  Future<void> uploadUserProfilePic(
    UploadUserProfilePic event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      if (state.image != null) {
        await ProfileRepo.uploadUserProfilePic(
          id: event.id,
          image: state.image!,
          context: event.context,
        );
      } else {
        SnackBarClass.warningSnackBar(
          context: event.context,
          message: 'Please Select an Image',
        );
      }
    } catch (error) {
      emit(state.copyWith(isUserUpdate: false));
    }
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController universityNameController = TextEditingController();
  TextEditingController universityLocationController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController courseOfStudyController = TextEditingController();

  Future<void> getCurrentUser(
    GetCurrentUser event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(onGetUser: true));
      final userProfile = await ProfileRepo.getCurrentUser(id: event.id);
      final user = userProfile.responseBody;
      emit(state.copyWith(user: user, onGetUser: false));
    } catch (error) {
      emit(state.copyWith(onGetUser: false, errorMessage: error.toString()));
    }
  }

  Future<void> pickUserProfilePic(
    PickUserProfilePic event,
    Emitter<ProfileState> emit,
  ) async {
    File? image = await HelperFunctions.pickImage(context: event.context);
    if (image != null) {
      emit(state.copyWith(image: image));
    }
  }

  Future<void> updateCurrentUser(
    UpdateCurrentUser event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      UserUpdateBody userUpdateBody = UserUpdateBody(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        phoneNumber: phoneNumberController.text.trim(),
        universityName: universityNameController.text.trim(),
        universityLocation: universityLocationController.text.trim(),
        city: cityController.text.trim(),
        dateOfBirth: dateOfBirthController.text.trim(),
        gender: genderController.text.trim(),
        country: countryController.text.trim(),
        courseOfStudy: courseOfStudyController.text.trim(),
      );
      emit(state.copyWith(isUserUpdate: true));
      await ProfileRepo.updateCurrentUser(
        id: event.id,
        userUpdateBody: userUpdateBody,
        context: event.context,
      );
      emit(state.copyWith(isUserUpdate: false));
    } catch (error) {
      emit(state.copyWith(isUserUpdate: false));
    }
  }

  @override
  ProfileState? fromJson(Map<String, dynamic> json) {
    try {
      return ProfileState(
        user: User.fromJson(json[BlocKeys.userKey]),
        onGetUser: false,
        errorMessage: '',
        isUserUpdate: false,
        image: null,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(ProfileState state) {
    try {
      if (state.user == null) return null;
      return {BlocKeys.userKey: state.user!.toJson()};
    } catch (_) {
      return null;
    }
  }
}
