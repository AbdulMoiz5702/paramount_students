import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SignupEvent extends Equatable {
  @override
  List<Object> get  props => [];
}


class SignUpUser extends SignupEvent {
  final BuildContext context;
  SignUpUser({required this.context});

  @override
  List<Object> get  props => [context];
}


