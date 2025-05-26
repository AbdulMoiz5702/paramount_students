import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract  class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class GetCurrentUser extends ProfileEvent {
  final int id;
  GetCurrentUser({required this.id});
  @override
  List<Object?> get props => [id];
}


class UpdateCurrentUser extends ProfileEvent {
  final int id;
  final BuildContext context;
  UpdateCurrentUser({required this.id,required this.context});
  @override
  List<Object?> get props => [id];
}

class UploadUserProfilePic extends ProfileEvent {
  final int id;
  final BuildContext context;
  UploadUserProfilePic({required this.id,required this.context});
  @override
  List<Object?> get props => [id];
}



class PickUserProfilePic extends ProfileEvent {
  final BuildContext context;
  PickUserProfilePic({required this.context});
  @override
  List<Object?> get props => [context];
}
