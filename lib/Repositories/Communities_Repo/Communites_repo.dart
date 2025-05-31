



import 'package:flutter/foundation.dart';
import 'package:paramount_student/models/Communities_models/Communities_model.dart';

import '../../core/exceptions/net_work_excptions.dart';
import '../../core/helper_fuctions/current_access_token.dart';
import '../../core/services/Apis_services/Http_Ap_iService.dart';
import '../../core/services/Network_services/app_apis.dart';
import '../../core/services/Network_services/headers_formats.dart';

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

  static Future<CommunitiesResponseModel> getSingleCommunities({required int id}) async {
    try {
      final url = '${AppApis.getSingleCommunities}${id.toString()}';
      return await httpApiService.get(
        url,
        headers: HeadersFormats.bearerTokenHeaders(
          token: CurrentUserSecrets.accessToken,
        ),
        fromJson: CommunitiesResponseModel.fromJson,
      );
    } catch (error) {
      final errorMessage = ExceptionHandler.getMessage(error);
      throw Exception(errorMessage);
    }
  }


}