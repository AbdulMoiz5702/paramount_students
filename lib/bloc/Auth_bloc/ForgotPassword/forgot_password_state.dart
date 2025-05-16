

import 'package:equatable/equatable.dart';

class ForgotPasswordState extends Equatable {
  final bool isLoading;
  const ForgotPasswordState({required this.isLoading});

  ForgotPasswordState copyWith({bool ? isLoading}){
    return ForgotPasswordState(isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [isLoading];


}
