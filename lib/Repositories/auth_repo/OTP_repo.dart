// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import '../../core/exceptions/net_work_excptions.dart';
import '../../core/helper_fuctions/snack_bar.dart';
import '../../core/routes/routes.dart';
import '../../core/services/Apis_services/Http_Ap_iService.dart';
import '../../core/services/Network_services/app_apis.dart';
import '../../core/services/Network_services/headers_formats.dart';
import '../../core/services/Shared_Preferences_Services/Shared_Preferences_Services.dart';
import '../../models/Auth_models/otp_models.dart';

class OtpRepo {
  static HttpApiService httpApiService = HttpApiService();

  static Future<OTPResponse> confirmOtp({
      required BuildContext context,
      required String otp,
      required String id
  }) async {
    try {
      final String url = '${AppApis.confirmOtp}otp=$otp&id=$id';
      final response = await httpApiService.postWithoutToJson(url,
          headers: HeadersFormats.defaultHeaders(),
          fromJson: OTPResponse.fromJson);
      if (response.statusCode == 200) {
        final accessToken = response.responseBody!.accessToken;
        await SharedPrefServices.savePrefData(key:SharedPrefKeys.accessToken,value:accessToken,);
        Navigator.pushNamedAndRemoveUntil(context, Routes.bottomNav, (route) => false);
      }
      return response;
    } catch (error) {
      ExceptionHandler.handle(error, context);
      rethrow;
    }
  }

  static Future<OTPResponse> resentOTp({
    required BuildContext context,
    required String email,
  }) async {
    try {
      final String url = '${AppApis.resendOtp}$email';
      final response = await httpApiService.postWithoutToJson(
          url,
          headers: HeadersFormats.defaultHeaders(),
          fromJson: OTPResponse.fromJson);
      if (response.statusCode == 200) {
        SnackBarClass.successSnackBar(context: context, message: 'We have sent you a OTP at your email');
      }
      return response;
    } catch (error,s) {
      debugPrint('error:$error details : $s ');
      ExceptionHandler.handle(error, context);
      rethrow;
    }
  }





}
