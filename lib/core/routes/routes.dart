import 'package:flutter/material.dart';
import 'package:paramount_student/bloc/Chats/chat_event.dart';
import 'package:paramount_student/models/user_models/user_profile_model.dart';
import 'package:paramount_student/views/screens/Auth_screens/ForgotPassword/forgot_password-screen.dart';
import 'package:paramount_student/views/screens/Chats/Get_all_chats.dart';
import 'package:paramount_student/views/screens/Communites_Detial/communities_detail_screen.dart';
import 'package:paramount_student/views/screens/home/Home_screen.dart';
import '../../views/screens/Auth_screens/Login/login_screen.dart';
import '../../views/screens/Auth_screens/Otp/Otp_screen.dart';
import '../../views/screens/Auth_screens/Signup/signUp_screen.dart';
import '../../views/screens/BottomNav/BottomNav_screen.dart';
import '../../views/screens/Porfile/Profile_Screen.dart';
import '../../views/screens/Porfile/Update_User_Profile.dart';
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

  // ----------------- Communities screens routes ----------------------------- //
  static const String communitiesDetailScreen = 'CommunitiesDetailScreen';


  // ----------------- Home Screens routes ----------------------------- //
  static const String homeScreen = 'HomeScreen';

  // ----------------- Chats screens routes ----------------------------- //
  static const String getAllChats = 'GetAllChats';

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

    // ----------------- Communities screens routes ----------------------------- //
      case communitiesDetailScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final id = args['id'] as int;
        return MaterialPageRoute(builder: (_) => CommunitiesDetailScreen(id: id,));

    // ----------------- Chats screens routes ----------------------------- //
      case getAllChats:
        return MaterialPageRoute(builder: (_) =>  const GetAllChatsScreen());


    // ----------------- Home Screens routes ----------------------------- //
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

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
