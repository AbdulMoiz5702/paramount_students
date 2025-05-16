import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:paramount_student/views/screens/BottomNav/widgets/bottom_nav_item.dart';

import '../../../core/presentation/image_constant.dart';
import '../../../core/presentation/list.dart';



class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List<CurvedNavigationBarItem> items = List.generate(4, (index) {
      String assetPath;
      String label;
      double heightFactor;
      switch (index) {
        case 0:
          assetPath = ImageConstant.ic_home_bottom;
          label = 'Home';
          heightFactor = 0.031;
          break;
        case 1:
          assetPath = ImageConstant.ic_checklst_bottom;
          label = 'Listing';
          heightFactor = 0.035;
          break;
        case 2:
          assetPath = ImageConstant.ic_add_bottom;
          label = 'Sell';
          heightFactor = 0.035;
          break;
        case 3:
          assetPath = ImageConstant.ic_setting2_bottom;
          label = 'Profile';
          heightFactor = 0.027;
          break;
        default:
          assetPath = '';
          label = '';
          heightFactor = 0.03;
      }
      return buildNavItem(
        index: index,
        currentIndex: currentIndex,
        assetPath: assetPath,
        label: label,
        heightFactor: heightFactor,
        context: context,
      );
    });
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        height: 65.0,
        color: AppColor.whiteColor,
        animationCurve: Curves.easeIn,
        buttonBackgroundColor: AppColor.darkGrey,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 300),
        items: items,
        onTap: (index) {
          ref.read(bottomNavProvider.notifier).changeIndex(index: index);
        },
      ),
    );
  }
}
