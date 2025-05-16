import 'package:flutter/material.dart';
import 'package:paramount_student/core/helper_fuctions/snack_bar.dart';
import '../../core/exceptions/net_work_excptions.dart';
import '../../core/routes/routes.dart';
import '../../core/services/Apis_services/Http_Ap_iService.dart';
import '../../core/services/Network_services/app_apis.dart';
import '../../core/services/Network_services/headers_formats.dart';
import '../../models/Auth_models/forgot_password.dart';


class ForgotPasswordRepo {

  static HttpApiService httpApiService = HttpApiService();



  static Future<ForgotPasswordResponse> forgotPassword({
    required BuildContext context,
    required String email,
  }) async {
    try {
      final String url = '${AppApis.forgotPassword}$email';
      final response = await httpApiService.postWithoutToJson(
          url,
          headers: HeadersFormats.defaultHeaders(),
          fromJson: ForgotPasswordResponse.fromJson);
      if (response.statusCode == 200) {
        Navigator.pushNamedAndRemoveUntil(context, Routes.verifyOtp, (route) => false,arguments: {'id':response.responseBody.userData.id.toString(),'email':email});
        SnackBarClass.successSnackBar(context: context, message: 'Confirmation email has been sent to your email');
      }
      return response;
    } catch (error) {
      ExceptionHandler.handle(error, context);
      rethrow;
    }
  }

}