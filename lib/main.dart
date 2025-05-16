import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paramount_student/bloc/Auth_bloc/ForgotPassword/forgot_password_bloc.dart';
import 'package:paramount_student/bloc/Splash/splash_bloc.dart';
import 'bloc/Auth_bloc/Otp_Bloc/otp_bloc.dart';
import 'bloc/Auth_bloc/Signup_bloc/signup_bloc.dart';
import 'bloc/Auth_bloc/login_bloc/login_Bloc.dart';
import 'core/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final futures = await Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]),
  ]);
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=> SignupBloc()),
        BlocProvider(create: (_)=> LoginBloc()),
        BlocProvider(create: (_)=> OtpBloc()),
        BlocProvider(create: (_)=> SplashBloc()),
        BlocProvider(create: (_)=> ForgotPasswordBloc()),
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute:  Routes.splash,
      ),
    );
  }
}

