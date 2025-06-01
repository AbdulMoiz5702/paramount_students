import 'package:flutter/cupertino.dart';
import 'package:paramount_student/core/services/Network_services/app_apis.dart';
import 'package:paramount_student/models/Events_models/Events_model.dart';
import '../../core/exceptions/net_work_excptions.dart';
import '../../core/helper_fuctions/current_access_token.dart';
import '../../core/services/Apis_services/Http_Ap_iService.dart';
import '../../core/services/Network_services/headers_formats.dart';
import '../../models/Events_models/Single_Event_model.dart';

class EventsRepo {

  static HttpApiService httpApiService = HttpApiService();

  static Future<EventsResponseModel> getAllEvents() async {
    try {
      final url = AppApis.getAllEvents;
      return await httpApiService.postGetter(
        url,
        headers: HeadersFormats.bearerTokenHeaders(
          token: CurrentUserSecrets.accessToken,
        ),
        fromJson:  (json) => EventsResponseModel.fromJson(json),
      );
    } catch (error,stackTrace) {
      debugPrint('getAllEvents $error $stackTrace');
      final errorMessage = ExceptionHandler.getMessage(error);
      throw Exception(errorMessage);
    }
  }

  static Future<SingleEventsResponseModel> getSingleEvent({required int id}) async {
    try {
      final url = '${AppApis.getSingleEvents}${id.toString()}';
      return await httpApiService.get(
        url,
        headers: HeadersFormats.bearerTokenHeaders(
          token: CurrentUserSecrets.accessToken,
        ),
        fromJson: SingleEventsResponseModel.fromJson,
      );
    } catch (error) {
      final errorMessage = ExceptionHandler.getMessage(error);
      throw Exception(errorMessage);
    }
  }

}