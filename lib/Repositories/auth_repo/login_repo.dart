// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import '../../core/exceptions/net_work_excptions.dart';
import '../../core/helper_fuctions/snack_bar.dart';
import '../../core/routes/routes.dart';
import '../../core/services/Apis_services/Http_Ap_iService.dart';
import '../../core/services/Network_services/app_apis.dart';
import '../../core/services/Network_services/headers_formats.dart';
import '../../core/services/Shared_Preferences_Services/Shared_Preferences_Services.dart';
import '../../models/Auth_models/login_models.dart';

class LoginRepo {

  static HttpApiService httpApiService = HttpApiService();


  static Future<LoginResponse> loginUser({
    required LoginRequestModel loginRequestModel,
    required BuildContext context,
  }) async {
    try {
      final response = await httpApiService.post<LoginResponse>(
        AppApis.login,
        headers: HeadersFormats.defaultHeaders(),
        body: loginRequestModel.toJson(),
        fromJson: (json) => LoginResponse.fromJson(json),
      );
      if(response.statusCode == 200){
        final accessToken = response.responseBody.accessToken;
        if (accessToken != null) {
          await SharedPrefServices.savePrefData(SharedPrefKeys.accessToken, accessToken,);
          Navigator.pushNamedAndRemoveUntil(context, Routes.bottomNav, (route) => false,);
        }
      }
      return response;
    } catch (error) {
      Future.microtask((){
        final errorMessage = ExceptionHandler.getMessage(error);
        if(ExceptionHandler.statusCode == 403){
          final otpData = ExceptionHandler.getUserOTPData(error);
          if (otpData != null) {
            Navigator.pushNamed(context, Routes.verifyOtp, arguments: {'id': otpData.id.toString(),'email':loginRequestModel.email},);
          }
          SnackBarClass.successSnackBar(context: context, message: errorMessage);
        }else{
          SnackBarClass.errorSnackBar(context: context, message: errorMessage);
        }
      });
      rethrow;
    }
  }




}