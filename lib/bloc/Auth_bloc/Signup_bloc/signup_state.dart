


import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final bool isLoading;
  const SignupState({required this.isLoading});

  SignupState copyWith({bool ? isLoading}){
    return SignupState(isLoading: isLoading ?? this.isLoading);
  }


  @override
  List<Object?> get props =>[isLoading];

}
