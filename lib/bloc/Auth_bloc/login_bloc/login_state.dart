


import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isLoginLoading;
  const LoginState({required this.isLoginLoading});

  LoginState copyWith({bool ? isLoginLoading}){
    return LoginState(isLoginLoading: isLoginLoading ?? this.isLoginLoading);
  }

  @override
  List<Object?> get props => [isLoginLoading];

}
