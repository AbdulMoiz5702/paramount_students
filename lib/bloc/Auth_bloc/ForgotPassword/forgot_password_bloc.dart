import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:paramount_student/Repositories/auth_repo/forgot_password.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';


class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordState(isLoading: false)) {
    on<ForgetPassword>(forgotPassword);
  }

  TextEditingController emailController = TextEditingController();

  Future<void> forgotPassword(ForgetPassword event,Emitter<ForgotPasswordState> emit) async{
    try{
      emit(state.copyWith(isLoading: true));
      await ForgotPasswordRepo.forgotPassword(context: event.context, email:emailController.text.trim());
      emit(state.copyWith(isLoading: false));
    }catch(e){
      emit(state.copyWith(isLoading: false));
    }
  }

}
