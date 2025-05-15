import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../views/common/text_widgets.dart';
import '../presentation/app_colors.dart';
import '../presentation/font_manager.dart';

class SnackBarClass {
  
  static successSnackBar({required BuildContext context ,required String message}){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        hitTestBehavior: HitTestBehavior.deferToChild,
        content: lightText(title: message,color: AppColor.whiteColor),
        backgroundColor: AppColor.successColor,
        duration: const Duration(seconds: 5),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
        margin:  const  EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        dismissDirection: DismissDirection.horizontal,
        onVisible: () {
        },
        showCloseIcon: true,
        closeIconColor: AppColor.whiteColor,
      ),
    );
  }

  static errorSnackBar({required BuildContext context ,required String message}){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        hitTestBehavior: HitTestBehavior.deferToChild,
        content: lightText(title: message,color: AppColor.whiteColor),
        backgroundColor: AppColor.errorColor,
        duration: const Duration(seconds: 5),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
        margin:  const  EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        dismissDirection: DismissDirection.horizontal,
        onVisible: () {
        },
        showCloseIcon: true,
        closeIconColor: AppColor.whiteColor,
      ),
    );
  }

  static warningSnackBar({required BuildContext context ,required String message}){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        hitTestBehavior: HitTestBehavior.deferToChild,
        content: lightText(title: message,color: AppColor.blackColor, fontSize: AppTextSize.regular, fontWeight: AppTextWeight.semiBold ),
        backgroundColor: AppColor.warningColor,
        duration: const Duration(seconds: 5),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
        margin:  const  EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        dismissDirection: DismissDirection.horizontal,
        onVisible: () {
        },
        showCloseIcon: true,
        closeIconColor: AppColor.blackColor,
      ),
    );
  }
  
}