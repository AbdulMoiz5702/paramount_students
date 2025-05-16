import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import '../../../../core/presentation/app_colors.dart';
import '../../../../core/presentation/font_manager.dart';
import '../../../../core/presentation/styles_manager.dart';
import '../../../common/image_widget.dart';

CurvedNavigationBarItem buildNavItem({
  required int index,
  required int currentIndex,
  required String assetPath,
  required String label,
  required double heightFactor,
  required BuildContext context,
}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  return CurvedNavigationBarItem(
    child: SizedBox(
      width: currentIndex == index ? screenWidth * 0.065 : screenWidth * 0.06,
      height: currentIndex == index ? screenHeight * heightFactor : screenHeight * 0.03,
      child: ImageWidget(
        assetPath: assetPath,
        isImageColor: true,
        iconColor: currentIndex == index ? Colors.white : AppColor.primaryColor,
      ),
    ),
    label: label,
    labelStyle: getLightTextStyle(
      color: AppColor.darkGrey,
      fontSize: currentIndex == index ? AppTextSize.light : AppTextSize.thin,
      fontWeight: currentIndex == index ? AppTextWeight.bold : AppTextWeight.medium,
      fontFamily: FontConstants.fontFamily,
    ),
  );
}