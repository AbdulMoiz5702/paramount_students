import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoading extends StatelessWidget {
  final Color color;
  final bool isCenter;
  final double height;
  final double width;
  final String imagePath;

  const CustomLoading({
    super.key,
    this.color = Colors.black,
    this.isCenter = true,
    this.height = 0,
    this.width = 0,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final loader = Lottie.asset(
      imagePath,
      height: MediaQuery.sizeOf(context).height * height,
      width: MediaQuery.sizeOf(context).width * width,
      fit: BoxFit.contain,
    );
    return isCenter ? Center(child: loader) : loader;
  }
}






