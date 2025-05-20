

import 'package:equatable/equatable.dart';
import 'package:paramount_student/models/user_models/user_profile_model.dart';

class ProfileState extends Equatable {

  final User ? user;
  final bool onGetUser;
  final String errorMessage ;
  const ProfileState({required this.user,required this.onGetUser,required this.errorMessage});


  ProfileState copyWith({User ? user,bool ? onGetUser,String ? errorMessage}){
    return ProfileState(user: user ?? this.user,onGetUser:onGetUser ?? this.onGetUser,errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [user,onGetUser,errorMessage];
}
