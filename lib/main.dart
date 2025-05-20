import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:paramount_student/bloc/Auth_bloc/ForgotPassword/forgot_password_bloc.dart';
import 'package:paramount_student/bloc/BottomNav/bottom_nav_bloc.dart';
import 'package:paramount_student/bloc/Profile/profile_bloc.dart';
import 'package:paramount_student/bloc/Splash/splash_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'bloc/Auth_bloc/Otp_Bloc/otp_bloc.dart';
import 'bloc/Auth_bloc/Signup_bloc/signup_bloc.dart';
import 'bloc/Auth_bloc/login_bloc/login_Bloc.dart';
import 'core/routes/routes.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final results = await Future.wait([
        () async {
        if (kIsWeb) {
        return await HydratedStorage.build(
          storageDirectory: HydratedStorageDirectory.web,
        );
      } else {
        final dir = await getTemporaryDirectory();
        return await HydratedStorage.build(
          storageDirectory: HydratedStorageDirectory((dir).path),
        );
      }
    }(),
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
  ]);
  HydratedBloc.storage = results[0] as HydratedStorage;
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
        BlocProvider(create: (_)=> BottomNavBloc()),
        BlocProvider(create: (_)=> ProfileBloc()),
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute:  Routes.splash,
      ),
    );
  }
}

