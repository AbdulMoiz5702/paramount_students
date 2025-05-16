import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ForgotPasswordEvent extends Equatable{
  @override
  List<Object> get props => [];
}


class ForgetPassword extends ForgotPasswordEvent {
  final BuildContext context;
  ForgetPassword({required this.context});
  @override
  List<Object> get props => [context];
}
