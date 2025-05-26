import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paramount_student/bloc/Profile/profile_bloc.dart';
import 'package:paramount_student/core/exceptions/net_work_excptions.dart';
import 'package:paramount_student/core/helper_fuctions/current_access_token.dart';
import 'package:paramount_student/core/helper_fuctions/snack_bar.dart';
import 'package:paramount_student/core/services/Network_services/app_apis.dart';
import 'package:paramount_student/core/services/Network_services/headers_formats.dart';
import 'package:paramount_student/models/user_models/user_profile_model.dart';
import 'package:paramount_student/models/user_models/user_update_model.dart';
import '../../core/services/Apis_services/Http_Ap_iService.dart';
import '../../models/user_models/uplaod_user_image.dart';

class ProfileRepo {

  static HttpApiService httpApiService = HttpApiService();

  static Future<UserProfileModel> getCurrentUser({required int id}) async {
    try {
      final url = '${AppApis.getSingleUser}${id.toString()}';
      return await httpApiService.get(
        url,
        headers: HeadersFormats.bearerTokenHeaders(
          token: CurrentUserSecrets.accessToken,
        ),
        fromJson: UserProfileModel.fromJson,
      );
    } catch (error) {
      final errorMessage = ExceptionHandler.getMessage(error);
      throw Exception(errorMessage);
    }
  }

  static Future<UserUpdateModel> updateCurrentUser({required int id,required UserUpdateBody userUpdateBody,required BuildContext context}) async {
    try {
      final url = '${AppApis.updateCurrentUser}${id.toString()}';
      return await httpApiService.post(
        url,
        headers: HeadersFormats.bearerTokenHeaders(token: CurrentUserSecrets.accessToken,),
        fromJson: UserUpdateModel.fromJson,
        body: userUpdateBody.toJson()
      );
    } catch (error) {
      ExceptionHandler.handle(error, context);
      rethrow;
    }
  }

  static Future<UploadProfilePic> uploadUserProfilePic({required int id,required File image,required BuildContext context}) async {
    try {
      final url = '${AppApis.updateUserPic}${id.toString()}';
      final response =  await httpApiService.postImage(
          url,
          headers:HeadersFormats.bearerTokenHeaders(token: CurrentUserSecrets.currentUserId),
          imageFile: image,
          imageFieldName:'image',
      );
      if (response.statusCode == 200) {
        SnackBarClass.successSnackBar(context: context, message: response.responseBody);
      }
      return response;
    } catch (error) {
      ExceptionHandler.handle(error, context);
      rethrow;
    }
  }



  static initializeControllersData({required User user,required BuildContext context}){
    final bloc = context.read<ProfileBloc>();
    Future.microtask((){
      bloc.firstNameController.text = user.firstName;
      bloc.lastNameController.text = user.lastName;
      bloc.phoneNumberController.text = user.phoneNumber ?? '';
      bloc.universityNameController.text = user.userDetail?.universityName ?? '';
      bloc.universityLocationController.text = user.userDetail?.universityLocation ?? '';
      bloc.cityController.text = user.userDetail?.city ?? '';
      bloc.dateOfBirthController.text = user.userDetail?.dateOfBirth ?? '';
      bloc.genderController.text = user.userDetail?.dateOfBirth ?? '';
      bloc.countryController.text = user.userDetail?.country ?? '';
      bloc.courseOfStudyController.text = user.userDetail?.courseOfStudy ?? '';
    });
  }


}
