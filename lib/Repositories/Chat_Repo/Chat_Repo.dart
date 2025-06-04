


import 'package:flutter/foundation.dart';

import '../../core/exceptions/net_work_excptions.dart';
import '../../core/helper_fuctions/current_access_token.dart';
import '../../core/services/Apis_services/Http_Ap_iService.dart';
import '../../core/services/Network_services/app_apis.dart';
import '../../core/services/Network_services/headers_formats.dart';
import '../../models/Chat_Models/All_chat_list.dart';

class ChatsRepo {

  static HttpApiService httpApiService = HttpApiService();

  static Future<ChatListResponse> getAllChats() async {
    try {
      final url = AppApis.getAllChats;
      return await httpApiService.postGetter(
        url,
        headers: HeadersFormats.bearerTokenHeaders(
          token: CurrentUserSecrets.accessToken,
        ),
        fromJson:(json) => ChatListResponse.fromJson(json),
      );
    } catch (error,stackTrace) {
      debugPrint('ChatListResponse $error $stackTrace');
      final errorMessage = ExceptionHandler.getMessage(error);
      throw Exception(errorMessage);
    }
  }


}