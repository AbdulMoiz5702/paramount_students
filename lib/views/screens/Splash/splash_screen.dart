import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paramount_student/bloc/Splash/splash_bloc.dart';
import 'package:paramount_student/bloc/Splash/splash_event.dart';
import 'package:paramount_student/core/presentation/image_constant.dart';
import 'package:paramount_student/views/common/custom_loading.dart';
import 'package:paramount_student/views/common/image_widget.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(CheckUserStatus(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  ImageWidget(assetPath: ImageConstant.ic_user_logo,)
      ),
    );
  }
}
