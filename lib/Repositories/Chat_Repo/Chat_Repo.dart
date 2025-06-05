


import 'package:flutter/foundation.dart';

import '../../core/exceptions/net_work_excptions.dart';
import '../../core/helper_fuctions/current_access_token.dart';
import '../../core/services/Apis_services/Http_Ap_iService.dart';
import '../../core/services/Network_services/app_apis.dart';
import '../../core/services/Network_services/headers_formats.dart';
import '../../models/Chat_Models/All_chat_list.dart';
import '../../models/Chat_Models/Chat_messages_model.dart';

class ChatsRepo {

  static HttpApiService httpApiService = HttpApiService();

  static Future<ChatListResponse> getAllChats() async {
    try {
      final url = AppApis.getAllChats;
      return await httpApiService.get(
        url,
        headers: HeadersFormats.bearerTokenHeaders(
          token: CurrentUserSecrets.accessToken,
        ),
        fromJson:(json) => ChatListResponse.fromJson(json),
      );
    } catch (error,stackTrace) {
      final errorMessage = ExceptionHandler.getMessage(error);
      throw Exception(errorMessage);
    }
  }

  static Future<ChatMessagesResponse> getChatsMessages({required int id}) async {
    try {
      final url = '${AppApis.getSingleChats}$id';
      return await httpApiService.get(
        url,
        headers: HeadersFormats.bearerTokenHeaders(
          token: CurrentUserSecrets.accessToken,
        ),
        fromJson:(json) => ChatMessagesResponse.fromJson(json),
      );
    } catch (error,stackTrace) {
      debugPrint('ChatMessagesResponse $error $stackTrace');
      final errorMessage = ExceptionHandler.getMessage(error);
      throw Exception(errorMessage);
    }
  }


}