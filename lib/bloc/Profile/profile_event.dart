import 'package:equatable/equatable.dart';

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
