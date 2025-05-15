import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/Auth_bloc/Signup_bloc/signup_bloc.dart';
import '../../../../bloc/Auth_bloc/Signup_bloc/signup_event.dart';
import '../../../../bloc/Auth_bloc/Signup_bloc/signup_state.dart';
import '../../../../core/helper_fuctions/format_validator.dart';
import '../../../../core/presentation/image_constant.dart';
import '../../../../core/routes/routes.dart';
import '../../../common/custom_button.dart';
import '../../../common/custom_loading.dart';
import '../../../common/custom_sizedBox.dart';
import '../../../common/custom_textfeild.dart';
import '../../../common/text_widgets.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var provider = context.read<SignupBloc>();
    final key = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: key,
          child: Column(
            children: [
              const Sized(height: 0.05),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                        controller: provider.firstNameController,
                        hintText: 'First Name',
                        validate: (value) {
                          return FormValidators.validateNormalField(
                              value, 'First Name');
                        }),
                  ),
                  const Sized(width: 0.02),
                  Expanded(
                    child: CustomTextField(
                        controller: provider.lastNameController,
                        hintText: 'Last Name',
                        validate: (value) {
                          return FormValidators.validateNormalField(
                              value, 'First Name');
                        }),
                  ),
                ],
              ),
              const Sized(height: 0.02),
              CustomTextField(
                  controller: provider.emailController,
                  hintText: 'Email',
                  validate: (value) {
                    return FormValidators.validateEmail(value);
                  }),
              const Sized(height: 0.02),
              CustomTextField(
                  isPasswordField: true,
                  controller: provider.passwordController,
                  hintText: 'Password',
                  validate: (value) {
                    return FormValidators.validatePassword(value);
                  }),
              const Sized(height: 0.02),
              CustomTextField(
                  isPasswordField: true,
                  controller: provider.confirmPasswordController,
                  hintText: 'Password',
                  validate: (value) {
                    return FormValidators.validatePassword(value);
                  }),
              const Sized(height: 0.05),
              BlocBuilder<SignupBloc, SignupState>(
                buildWhen: (pre,current) => pre.isLoading != current.isLoading,
                builder: (context, state) {
                  return state.isLoading == true ? const CustomLoading(imagePath: ImageConstant.ic_loading_animation,height: 0.1,width: 0.2,): CustomButton(title: 'Signup', onTap: () {
                    if(key.currentState!.validate()){
                      if(provider.passwordController.text == provider.confirmPasswordController.text){
                        context.read<SignupBloc>().add(SignUpUser(context: context));
                      }
                    }
                  });
                },
              ),
              const Sized(height: 0.05),
              GestureDetector(onTap: (){
                Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
              },child: lightText(title: 'Already have an account? Login'),)
            ],
          ),
        ),
      ),
    );
  }
}
