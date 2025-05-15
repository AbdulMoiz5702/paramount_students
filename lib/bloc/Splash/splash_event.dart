

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SplashEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckUserStatus extends SplashEvent {
  final BuildContext context;
  CheckUserStatus({required this.context});
  @override
  List<Object> get props => [context];
}
