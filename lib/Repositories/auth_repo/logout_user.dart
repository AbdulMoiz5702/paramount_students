

import 'package:flutter/cupertino.dart';
import 'package:paramount_student/core/exceptions/net_work_excptions.dart';
import 'package:paramount_student/core/services/Shared_Preferences_Services/Shared_Preferences_Services.dart';
import '../../core/routes/routes.dart';

class LogoutRepo {


  static Future<void>  logoutUser({required BuildContext context}) async {
    try{
      Future.wait([
        SharedPrefServices.removePrefData(key: SharedPrefKeys.accessToken),
        SharedPrefServices.removePrefData(key: SharedPrefKeys.currentUserId),
      ]).then((value){
        Navigator.pushNamedAndRemoveUntil(context, Routes.login, (_)=> false);
      });
    }catch(error){
      ExceptionHandler.handle(error, context);
    }
  }

}