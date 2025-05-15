import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../../Repositories/auth_repo/OTP_repo.dart';
import 'otp_event.dart';
import 'otp_state.dart';


class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(const OtpState(isConfirmOtp: false, isResendOtp: false,secondsRemaining: 0)) {
    on<ConfirmOtp>(confirmOtp);
  }

  TextEditingController otpController = TextEditingController();
  Timer? _timer;

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
      startTimer(emit);
      emit(state.copyWith(isResendOtp: false));
    } catch (error) {
      emit(state.copyWith(isResendOtp: false));
    }
  }

  void startTimer(Emitter<OtpState> emit) {
    emit(state.copyWith(secondsRemaining: 60));
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining > 0) {
        emit(state.copyWith(secondsRemaining: state.secondsRemaining - 1));
      } else {
        timer.cancel();
      }
    });
  }


}
