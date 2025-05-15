// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:paramount_student/bloc/Splash/splash_event.dart';
import 'package:paramount_student/bloc/Splash/splash_state.dart';
import 'package:paramount_student/core/services/Shared_Preferences_Services/Shared_Preferences_Services.dart';
import '../../core/routes/routes.dart';



class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState()) {
    on<CheckUserStatus>(checkUserStatus);
  }

  void checkUserStatus(CheckUserStatus event,Emitter<SplashState> emit) async{
    try{
      final userToken = await SharedPrefServices.getPrefData(SharedPrefKeys.accessToken);
      if(userToken.isNotEmpty){
        Navigator.pushNamedAndRemoveUntil(event.context, Routes.bottomNav, (_)=> false);
      }
    }catch(error){
      Navigator.pushNamedAndRemoveUntil(event.context, Routes.login, (_)=> false);
    }
  }
}
