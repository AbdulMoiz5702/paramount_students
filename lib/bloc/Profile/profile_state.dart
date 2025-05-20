

import 'package:equatable/equatable.dart';
import 'package:paramount_student/models/user_models/user_profile_model.dart';

class ProfileState extends Equatable {

  final User ? user;
  final bool onGetUser;
  const ProfileState({required this.user,required this.onGetUser});


  ProfileState copyWith({User ? user,bool ? onGetUser}){
    return ProfileState(user: user ?? this.user,onGetUser:onGetUser ?? this.onGetUser);
  }

  @override
  List<Object?> get props => [user,onGetUser];
}
