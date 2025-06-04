


import 'package:equatable/equatable.dart';

class LogoutState extends Equatable {

  final bool isLogout;
  const LogoutState({required this.isLogout});

  LogoutState copyWith({bool ? isLogout}){
    return LogoutState(isLogout: isLogout ?? this.isLogout);
  }

  @override
  List<Object?> get props => [isLogout];

}
