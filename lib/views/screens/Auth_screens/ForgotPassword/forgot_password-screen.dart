import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paramount_student/bloc/Auth_bloc/ForgotPassword/forgot_password_bloc.dart';
import 'package:paramount_student/bloc/Auth_bloc/ForgotPassword/forgot_password_event.dart';
import 'package:paramount_student/bloc/Auth_bloc/ForgotPassword/forgot_password_state.dart';
import 'package:paramount_student/core/helper_fuctions/format_validator.dart';
import 'package:paramount_student/core/presentation/image_constant.dart';
import 'package:paramount_student/views/common/custom_button.dart';
import 'package:paramount_student/views/common/custom_loading.dart';
import 'package:paramount_student/views/common/custom_sizedBox.dart';
import 'package:paramount_student/views/common/custom_textfeild.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ForgotPasswordBloc>();
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Sized(height: 0.1),
            CustomTextField(
              controller: provider.emailController,
              hintText: 'Email',
              validate: (value) {
                return FormValidators.validateNormalField(value, 'Email');
              },
            ),
            Sized(height: 0.05),
            BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
              buildWhen: (pre, current) => pre.isLoading != current.isLoading,
              builder: (context, state) {
                return state.isLoading == true
                    ? CustomLoading(
                      imagePath: ImageConstant.ic_loading_animation,
                      height: 0.1,
                      width: 0.2,
                    )
                    : CustomButton(
                      title: 'Confirm',
                      onTap: () {
                        context.read<ForgotPasswordBloc>().add(
                          ForgetPassword(context: context),
                        );
                      },
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
