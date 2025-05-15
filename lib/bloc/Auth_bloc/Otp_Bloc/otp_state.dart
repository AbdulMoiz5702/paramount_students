


import 'package:equatable/equatable.dart';

class OtpState extends Equatable {
  final bool isConfirmOtp;
  final bool isResendOtp;
  final int secondsRemaining;
  const OtpState({required this.isConfirmOtp,required this.isResendOtp,required this.secondsRemaining,});
  OtpState copyWith({bool ? isConfirmOtp,bool ? isResendOtp,int ? secondsRemaining}){
    return OtpState(isConfirmOtp: isConfirmOtp ?? this.isConfirmOtp, isResendOtp: isResendOtp ?? this.isResendOtp,secondsRemaining: secondsRemaining ?? this.secondsRemaining);
  }
  @override
  List<Object?> get props => [isConfirmOtp,isResendOtp,secondsRemaining];

}
