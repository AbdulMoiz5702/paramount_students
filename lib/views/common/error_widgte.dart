import 'package:flutter/material.dart';
import '../../core/presentation/app_colors.dart';
import '../../core/presentation/font_manager.dart';
import '../../core/presentation/image_constant.dart';
import 'custom_button.dart';
import 'custom_loading.dart';
import 'custom_sizedBox.dart';
import 'text_widgets.dart';

class ErrorRetryWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;
  final String imagepath;
  final double sizedboxheight;
  final bool showButton;
  final double loadingheight;


  const ErrorRetryWidget({
  super.key,
  required this.errorMessage,
  required this.onRetry,
  this.loadingheight = 0.5,
    this.showButton = false,
    this.sizedboxheight = 0.05,
    this.imagepath = ImageConstant.ic_internet_lost_animation,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomLoading(imagePath: imagepath, height: loadingheight,width: 0.8,),
           Sized(height: sizedboxheight,),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: lightText(
              title:
              errorMessage,
              textAlign: TextAlign.center,
              color: AppColor.blackColor,
              fontWeight: AppTextWeight.semiBold,

            ),
          ),
           Sized(height: sizedboxheight,),
           showButton == true ?  CustomIconButton(
            width: 0.5,
            onTap: onRetry,
            iconData: Icons.refresh_rounded,
            title: 'Retry',
          ): Sized(),
          showButton == true ? Sized(height: sizedboxheight,) :  Sized(),
        ],
      ),
    );
  }
}
