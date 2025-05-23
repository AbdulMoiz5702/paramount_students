import 'package:flutter/material.dart';
import 'package:paramount_student/models/user_models/user_profile_model.dart';
import 'package:paramount_student/views/Porfile/Profile_Screen.dart';
import 'package:paramount_student/views/Porfile/Update_User_Profile.dart';
import 'package:paramount_student/views/screens/Auth_screens/ForgotPassword/forgot_password-screen.dart';
import '../../views/screens/Auth_screens/Login/login_screen.dart';
import '../../views/screens/Auth_screens/Otp/Otp_screen.dart';
import '../../views/screens/Auth_screens/Signup/signUp_screen.dart';
import '../../views/screens/BottomNav/BottomNav_screen.dart';
import '../../views/screens/Splash/splash_screen.dart';

class Routes {
  // ----------------- auth routes ----------------------------- //
  static const String signup = 'signup';
  static const String login = 'login';
  static const String auth = 'auth';
  static const String verifyOtp = 'verifyOtp';
  static const String forgotPassword = 'forgotPassword';
  static const String resetPasswordScreen = 'resetPasswordScreen';
  static const String authScreen = 'authScreen';

  // ----------------- splash routes ----------------------------- //
  static const String splash = 'splash';

  // ----------------- bottom Nav routes ----------------------------- //
  static const String bottomNav = 'bottomNav';

  // ----------------- profile screens routes ----------------------------- //
  static const String profileScreen = 'profileScreen';
  static const String updateProfileScreen = 'UpdateUserProfile';

  // ----------------- Listing screens routes ----------------------------- //


  // ----------------- Home Screens routes ----------------------------- //

  // ----------------- Follows screens routes ----------------------------- //

  // ----------------- ReportListingScreen screens routes ----------------------------- //

  // ----------------- NoInternetScreen screens routes ----------------------------- //

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
    // ----------------- auth routes ----------------------------- //
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case verifyOtp:
        final args = settings.arguments as Map<String, dynamic>;
        final id = args['id'] as String;
        final email = args['email'] as String;
        return MaterialPageRoute(builder: (_) => OTPScreen(id: id,email: email,));

    // ----------------- profile screens routes ----------------------------- //
      case profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case updateProfileScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final data = args['data'] as User;
        return MaterialPageRoute(builder: (_) => UpdateUserProfile(data: data,));

    // ----------------- bottom Nav routes ----------------------------- //
      case bottomNav:
        return MaterialPageRoute(builder: (_) => const BottomNavScreen());

    // ----------------- splash routes ----------------------------- //
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

    // ----------------- Route not found ----------------------------- //
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
