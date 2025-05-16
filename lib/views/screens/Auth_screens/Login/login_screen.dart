import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/Auth_bloc/login_bloc/login_Bloc.dart';
import '../../../../bloc/Auth_bloc/login_bloc/login_event.dart';
import '../../../../bloc/Auth_bloc/login_bloc/login_state.dart';
import '../../../../core/helper_fuctions/format_validator.dart';
import '../../../../core/presentation/image_constant.dart';
import '../../../../core/routes/routes.dart';
import '../../../common/custom_button.dart';
import '../../../common/custom_loading.dart';
import '../../../common/custom_sizedBox.dart';
import '../../../common/custom_textfeild.dart';
import '../../../common/text_widgets.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    var provider = context.read<LoginBloc>();
    return Scaffold(
      appBar: AppBar(),
      body:SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: key,
          child: Column(
            children: [
              const Sized(height: 0.05),
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
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(onTap: (){
                  Navigator.pushNamed(context, Routes.forgotPassword);
                },child: lightText(title: 'Forgot Password?'),),
              ),
              const Sized(height: 0.05),
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (pre,current) => pre.isLoginLoading != current.isLoginLoading,
                builder: (context, state) {
                  return state.isLoginLoading == true ? const CustomLoading(imagePath: ImageConstant.ic_loading_animation,height: 0.1,width: 0.2,): CustomButton(title: 'Login', onTap: () {
                    if(key.currentState!.validate()){
                      context.read<LoginBloc>().add(LoginUser(context: context));
                    }
                  });
                },
              ),
              const Sized(height: 0.02),
              GestureDetector(onTap: (){
                Navigator.pushNamedAndRemoveUntil(context, Routes.signup, (route) => false);
              },child: lightText(title: 'Do\'nt have an account? Create Account'),)
            ],
          ),
        ),
      ),
    );
  }
}
