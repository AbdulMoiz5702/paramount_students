import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../views/common/custom_button.dart';
import '../../views/common/text_widgets.dart';
import '../presentation/app_colors.dart';
import '../presentation/font_manager.dart';


class DialogHelper {


  static void showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: mediumText(title: "Permission Required"),
          content: lightText(title: "This feature requires permission. Please enable it in settings."),
          actions: [
            CustomButton(title: 'Cancel', onTap: () => Navigator.pop(context),width: 0.03,),
            CustomButton(title: 'Allow', onTap: () async {
              Navigator.pop(context);
              await openAppSettings(); // Open settings
            },width: 0.03,),
          ],
        );
      },
    );
  }

  static void showCustomDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String firstButtonText,
    required VoidCallback onFirstButtonTap,
    required String secondButtonText,
    required VoidCallback onSecondButtonTap,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.start,
          backgroundColor: AppColor.backgroundColor,
          title: mediumText(
            title: title,
            color: AppColor.blackColor,
          ),
          content: lightText(
            title: content,
            color: AppColor.darkGrey,
          ),
          actions: [
            Wrap(
              spacing: 8, // space between buttons
              children: [
                CustomButton(
                  fontSize: AppTextSize.regular,
                  title: firstButtonText,
                  onTap: onFirstButtonTap,
                  width: 0.3, // use percentage of screen width
                  color: AppColor.successColor,
                ),
                CustomButton(
                  fontSize: AppTextSize.regular,
                  title: secondButtonText,
                  onTap: onSecondButtonTap,
                  width: 0.3,
                  color: AppColor.errorColor,
                ),
              ],
            )
          ],
        );
      },
    );
  }

}
