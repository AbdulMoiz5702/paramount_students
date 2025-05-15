import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import '../../../../bloc/Auth_bloc/Otp_Bloc/otp_bloc.dart';
import '../../../../bloc/Auth_bloc/Otp_Bloc/otp_event.dart';
import '../../../../bloc/Auth_bloc/Otp_Bloc/otp_state.dart';
import '../../../../core/presentation/app_colors.dart';
import '../../../../core/presentation/image_constant.dart';
import '../../../../core/presentation/styles_manager.dart';
import '../../../common/custom_button.dart';
import '../../../common/custom_loading.dart';
import '../../../common/custom_sizedBox.dart';
import '../../../common/text_widgets.dart';


class OTPScreen extends StatelessWidget {
  final String id;
  final String email;
  const OTPScreen({super.key,required this.id,required this.email});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<OtpBloc>();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const  Sized(height: 0.1,),
            OtpPinField(
              fieldWidth: MediaQuery.of(context).size.width * 0.12,
              onSubmit: (String value) {
                if (value.length == 4) {
                  provider.otpController.text = value;
                  print('OTP Submitted: $value');
                }
              },
              onChange: (String newValue) {
                if (newValue.length <= 4) {
                  provider.otpController.text = newValue;
                }
              },
              maxLength: 4,
              showDefaultKeyboard: true,
              otpPinFieldDecoration: OtpPinFieldDecoration.custom,
              otpPinFieldStyle: OtpPinFieldStyle(
                defaultFieldBorderColor:
                AppColor.blackColor.withOpacity(0.5),
                defaultFieldBackgroundColor: AppColor.backgroundColor,
                activeFieldBackgroundColor: AppColor.backgroundColor,
                activeFieldBorderColor: AppColor.blackColor,
                filledFieldBackgroundColor: AppColor.backgroundColor,
                filledFieldBorderColor: AppColor.blackColor,
                textStyle: getBoldTextStyle(color: AppColor.blackColor),
                fieldBorderRadius: 8.0,
                fieldBorderWidth: 0.7,
              ),
            ),
            const  Sized(height: 0.2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocBuilder<OtpBloc,OtpState>(
                buildWhen: (previous, current) =>
                previous.isResendOtp != current.isResendOtp ||
                previous.secondsRemaining != current.secondsRemaining,
                builder: (context,state) {
                    var data = state.secondsRemaining;
                    var loading = state.isResendOtp;
                    return data > 0
                        ? lightText(
                        title: "Resend in ${data}s") // Show countdown
                        : loading == true
                        ? const CustomLoading(
                      imagePath:
                      ImageConstant.ic_loading_animation,
                      height: 0.1,
                      width: 0.1,
                    )
                        : InkWell(
                      onTap: () {
                        context.read<OtpBloc>().add(ResentOtp(context: context, email: email));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: AppColor.primaryColor
                                        .withOpacity(0.7),
                                    width: 2.0))),
                        child: mediumText(
                            title: 'Send Code Again',
                            fontSize: 12.0,
                            color: AppColor.primaryColor), ),
                    );
                  },
                ),
              ],
            ),
            const  Sized(height: 0.05,),
            BlocBuilder<OtpBloc,OtpState>(
              buildWhen: (pre,current)=> pre.isConfirmOtp != current.isConfirmOtp,
                builder: (context,state){
                return state.isConfirmOtp == true ? const CustomLoading(imagePath: ImageConstant.ic_loading_animation) : CustomButton(title: 'Confirm', onTap: (){
                  context.read<OtpBloc>().add(ConfirmOtp(context: context, id: id));
                });
            }),
          ],
        ),
      ),
    );
  }
}
