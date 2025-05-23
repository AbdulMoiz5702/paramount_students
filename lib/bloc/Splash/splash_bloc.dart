// ignore_for_file: use_build_context_synchronously
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:paramount_student/bloc/Splash/splash_event.dart';
import 'package:paramount_student/bloc/Splash/splash_state.dart';
import 'package:paramount_student/core/helper_fuctions/current_access_token.dart';
import 'package:paramount_student/core/services/Shared_Preferences_Services/Shared_Preferences_Services.dart';
import '../../core/routes/routes.dart';



class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState()) {
    on<CheckUserStatus>(checkUserStatus);
  }

  void checkUserStatus(CheckUserStatus event,Emitter<SplashState> emit) async{
    try{
      final data = await Future.wait([
        SharedPrefServices.getPrefData(key: SharedPrefKeys.accessToken),
        SharedPrefServices.getPrefData(key: SharedPrefKeys.currentUserId),
      ]);
      final accessToken = data[0];
      final currentUserId = data[1];
      debugPrint('accessToken : $accessToken');
      debugPrint('currentUserId : $currentUserId');
      if(accessToken.isNotEmpty){
        CurrentUserSecrets.accessToken = accessToken;
        CurrentUserSecrets.currentUserId = currentUserId;
        Future.microtask((){
          Navigator.pushNamedAndRemoveUntil(event.context, Routes.bottomNav, (_)=> false);
        });
      }else{
        Future.microtask((){
          Navigator.pushNamedAndRemoveUntil(event.context, Routes.login, (_)=> false);
        });
      }
    }catch(error){
      Future.microtask((){
        Navigator.pushNamedAndRemoveUntil(event.context, Routes.signup, (_)=> false);
      });
    }
  }
}
