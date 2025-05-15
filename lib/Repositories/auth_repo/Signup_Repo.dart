// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import '../../core/exceptions/net_work_excptions.dart';
import '../../core/routes/routes.dart';
import '../../core/services/Apis_services/Http_Ap_iService.dart';
import '../../core/services/Network_services/app_apis.dart';
import '../../core/services/Network_services/headers_formats.dart';
import '../../models/Auth_models/signup_model.dart';

class SignupRepo {

 static HttpApiService httpApiService = HttpApiService();

 static Future<SignupResponseModel> signupUser({
    required SignupRequestModel signupRequest,
    required BuildContext context,
  }) async {
    try{
      final response = await httpApiService.post<SignupResponseModel>(
        AppApis.signup,
        headers: HeadersFormats.defaultHeaders(),
        body: signupRequest.toJson(),
        fromJson: (json) => SignupResponseModel.fromJson(json),
      );
      if(response.statusCode == 200){
        Navigator.pushNamedAndRemoveUntil(context, Routes.verifyOtp, (route) => false,arguments: {'id':response.responseBody.userdata.id.toString(),'email':signupRequest.email});
      }
      return response;
    }catch(error,s){
      ExceptionHandler.handle(error, context);
      rethrow;
    }
  }



}