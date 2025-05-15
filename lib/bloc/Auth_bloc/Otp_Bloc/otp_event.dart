import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class OtpEvent extends Equatable {
  @override
  List<Object> get props => [];
}



class ConfirmOtp extends OtpEvent {
  final BuildContext context;
  final String id;
  ConfirmOtp({required this.context,required this.id});

  @override
  List<Object> get props => [context,id];
}

class ResentOtp extends OtpEvent {
  final BuildContext context;
  final String email;
  ResentOtp({required this.context,required this.email});

  @override
  List<Object> get props => [context,email];
}

class StartTimer extends OtpEvent {
  StartTimer();
  @override
  List<Object> get props => [];
}
