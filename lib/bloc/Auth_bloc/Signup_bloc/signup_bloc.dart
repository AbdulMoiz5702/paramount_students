import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:paramount_student/bloc/Auth_bloc/Signup_bloc/signup_event.dart';
import 'package:paramount_student/bloc/Auth_bloc/Signup_bloc/signup_state.dart';
import '../../../Repositories/auth_repo/Signup_Repo.dart';
import '../../../models/Auth_models/signup_model.dart';


class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState(isLoading: false)) {
    on<SignUpUser>(signupUser);
  }

  TextEditingController firstNameController  = TextEditingController();
  TextEditingController lastNameController  = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();



  void  signupUser(SignUpUser event ,Emitter<SignupState> emit) async{
    SignupRequestModel signupRequest = SignupRequestModel(firstName: firstNameController.text.trim(), lastName: lastNameController.text.trim(), email: emailController.text.trim(), password: passwordController.text.trim());
    try{
      emit(state.copyWith(isLoading: true));
      await SignupRepo.signupUser(signupRequest: signupRequest, context: event.context);
      emit(state.copyWith(isLoading: false));
    }catch(e){
      emit(state.copyWith(isLoading: false));
    }
  }

}
