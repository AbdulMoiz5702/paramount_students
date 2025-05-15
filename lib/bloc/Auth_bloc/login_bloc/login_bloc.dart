import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../Repositories/auth_repo/login_repo.dart';
import '../../../models/Auth_models/login_models.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState(isLoginLoading: false)) {
    on<LoginUser>(loginUser);
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  Future<void> loginUser(LoginUser event,Emitter<LoginState> emit) async {
    LoginRequestModel loginRequestModel = LoginRequestModel(email: emailController.text.trim(), password: passwordController.text.trim());
    try{
      emit(state.copyWith(isLoginLoading: true));
      await LoginRepo.loginUser(loginRequestModel: loginRequestModel, context: event.context);
      emit(state.copyWith(isLoginLoading: false));
    }catch(e){
      emit(state.copyWith(isLoginLoading: false));
    }
  }
}
