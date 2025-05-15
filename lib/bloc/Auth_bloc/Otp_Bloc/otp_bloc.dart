import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../../Repositories/auth_repo/OTP_repo.dart';
import 'otp_event.dart';
import 'otp_state.dart';


class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(const OtpState(isConfirmOtp: false, isResendOtp: false,secondsRemaining: 0)) {
    on<ConfirmOtp>(confirmOtp);
    on<ResentOtp>(resendOtp);
    on<StartTimer>(startTimer);
  }

  TextEditingController otpController = TextEditingController();


  Future<void> confirmOtp(ConfirmOtp event ,Emitter<OtpState> emit) async {
    try{
      emit(state.copyWith(isConfirmOtp: true));
      await OtpRepo.confirmOtp(context: event.context, otp: otpController.text.trim(), id: event.id);
      emit(state.copyWith(isConfirmOtp: false));
    }catch(error){
      emit(state.copyWith(isConfirmOtp: false));
    }
  }

  Future<void> resendOtp(ResentOtp event ,Emitter<OtpState> emit) async {
    if (state.secondsRemaining > 0) return;
    try {
      emit(state.copyWith(isResendOtp: true));
      await OtpRepo.resentOTp(context: event.context, email: event.email);
      otpController.clear();
      emit(state.copyWith(isResendOtp: false));
      add(StartTimer());
    } catch (error) {
      emit(state.copyWith(isResendOtp: false));
    }
  }

  Future<void> startTimer(StartTimer event, Emitter<OtpState> emit) async {
    int remaining = 60;
    emit(state.copyWith(secondsRemaining: remaining));
    while (remaining > 0) {
      await Future.delayed(const Duration(seconds: 1));
      remaining--;
      if (emit.isDone) return;
      emit(state.copyWith(secondsRemaining: remaining));
    }
  }



}
