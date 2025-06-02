import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paramount_student/models/Communities_models/Communities_model.dart';
import '../../core/exceptions/net_work_excptions.dart';
import '../../core/helper_fuctions/current_access_token.dart';
import '../../core/helper_fuctions/snack_bar.dart';
import '../../core/services/Apis_services/Http_Ap_iService.dart';
import '../../core/services/Network_services/app_apis.dart';
import '../../core/services/Network_services/headers_formats.dart';
import '../../models/Communities_models/Single_communit_response.dart';
import '../../models/Communities_models/follow_community.dart';

class CommunitiesRepo {

  static HttpApiService httpApiService = HttpApiService();

  static Future<CommunitiesResponseModel> getAllCommunities() async {
    try {
      final url = AppApis.getAllCommunities;
      return await httpApiService.postGetter(
        url,
        headers: HeadersFormats.bearerTokenHeaders(
          token: CurrentUserSecrets.accessToken,
        ),
        fromJson:(json) => CommunitiesResponseModel.fromJson(json),
      );

    } catch (error,stackTrace) {
      debugPrint('getAllCommunities $error $stackTrace');
      final errorMessage = ExceptionHandler.getMessage(error);
      throw Exception(errorMessage);
    }
  }

  static Future<SingleCommunityResponseModel> getSingleCommunities({required int id}) async {
    try {
      final url = '${AppApis.getSingleCommunities}${id.toString()}';
      return await httpApiService.get(
        url,
        headers: HeadersFormats.bearerTokenHeaders(
          token: CurrentUserSecrets.accessToken,
        ),
        fromJson: SingleCommunityResponseModel.fromJson,
      );
    } catch (error) {
      final errorMessage = ExceptionHandler.getMessage(error);
      throw Exception(errorMessage);
    }
  }


  static Future<FollowUnFollowCommunityResponse> followCommunities({
    required BuildContext context,
    required int id,
  }) async {
    try {
      final String url = '${AppApis.followCommunities}$id/follow';
      final response = await httpApiService.postWithoutToJson(
          url,
          headers: HeadersFormats.defaultHeaders(),
          fromJson: FollowUnFollowCommunityResponse.fromJson);
      if (response.statusCode == 200) {
        SnackBarClass.successSnackBar(context: context, message: '🎉 You\'re now following the community. Stay tuned for updates and announcements!');
      }
      return response;
    } catch (error) {
      ExceptionHandler.handle(error, context);
      rethrow;
    }
  }

  static Future<FollowUnFollowCommunityResponse> unfollowCommunities({
    required BuildContext context,
    required int id,
  }) async {
    try {
      final String url = '${AppApis.unfollowCommunities}$id/unfollow';
      final response = await httpApiService.postWithoutToJson(
          url,
          headers: HeadersFormats.defaultHeaders(),
          fromJson: FollowUnFollowCommunityResponse.fromJson);
      if (response.statusCode == 200) {
        SnackBarClass.successSnackBar(context: context, message: '🎉 You\'re now following the community. Stay tuned for updates and announcements!');
      }
      return response;
    } catch (error) {
      ExceptionHandler.handle(error, context);
      rethrow;
    }
  }





}