
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LogoutEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class LogoutCurrentUser extends LogoutEvent{
  final BuildContext context;
  LogoutCurrentUser({required this.context});
  @override
  List<Object> get props => [context];
}
