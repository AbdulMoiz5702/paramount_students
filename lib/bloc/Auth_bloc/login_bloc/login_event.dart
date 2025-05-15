


import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props  => [];
}

class LoginUser extends LoginEvent {
  final BuildContext context;
  LoginUser({required this.context});

  @override
  List<Object> get props  => [context];
}
