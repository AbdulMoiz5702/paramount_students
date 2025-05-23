import 'package:paramount_student/core/exceptions/net_work_excptions.dart';
import 'package:paramount_student/core/helper_fuctions/current_access_token.dart';
import 'package:paramount_student/core/services/Network_services/app_apis.dart';
import 'package:paramount_student/core/services/Network_services/headers_formats.dart';
import 'package:paramount_student/models/user_models/user_profile_model.dart';
import 'package:paramount_student/models/user_models/user_update_model.dart';
import '../../core/services/Apis_services/Http_Ap_iService.dart';

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

  static Future<UserUpdateModel> updateCurrentUser({required int id,required UserUpdateBody userUpdateBody}) async {
    try {
      final url = '${AppApis.updateCurrentUser}${id.toString()}';
      return await httpApiService.post(
        url,
        headers: HeadersFormats.bearerTokenHeaders(token: CurrentUserSecrets.accessToken,),
        fromJson: UserUpdateModel.fromJson,
        body: userUpdateBody.toJson()
      );
    } catch (error) {
      final errorMessage = ExceptionHandler.getMessage(error);
      throw Exception(errorMessage);
    }
  }


}
