
import 'package:flutter/material.dart';
import 'package:paramount_student/views/common/text_widgets.dart';
import '../../core/presentation/app_colors.dart';
import '../../core/presentation/font_manager.dart';
import 'custom_sizedBox.dart';





class CustomButton extends StatelessWidget {
  final String title ;
  final VoidCallback onTap;
  final double height ;
  final double width ;
  final double imageheight ;
  final double imagewidth ;
  final Color color ;
  final Color borderColor ;
  final Color fontColor ;
  final double fontSize;
  final bool isimage;
  final String image;
  final FontWeight fontWeight ;
  const CustomButton({super.key, this.imageheight = 15, this.fontColor = AppColor.whiteColor, this.imagewidth = 15, this.isimage = false, this.image = '',required this.title,required this.onTap,this.height = 0.06,this.width = 1,this.color = AppColor.primaryColor,this.borderColor = AppColor.transparentColor,this.fontSize = AppTextSize.medium, this.fontWeight = AppTextWeight.medium,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.sizeOf(context).height *height ,
        width: MediaQuery.sizeOf(context).width * width,

        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor

          ),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isimage ? Row(
              children: [
                Image.asset(image, color: AppColor.whiteColor, height: imageheight, width: imagewidth,),
                Sized(
                  width: 0.015,
                )
              ],
            ) : SizedBox.shrink(),
            mediumText(title: title,fontSize: fontSize.toDouble(),color: fontColor,fontWeight:fontWeight ),
          ],
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final String title ;
  final VoidCallback onTap;
  final double height ;
  final double width ;
  final Color color ;
  final double fontSize;
  final FontWeight fontWeight ;
  final IconData iconData;
  final double radius ;
  const CustomIconButton({super.key,required this.title,required this.onTap,this.height = 0.06,this.width = 1,this.color = AppColor.blackColor,this.fontSize = AppTextSize.medium, this.fontWeight = AppTextWeight.medium,required this.iconData,this.radius = 30});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.sizeOf(context).height *height ,
        width: MediaQuery.sizeOf(context).width * width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(iconData,color: AppColor.whiteColor),
            const Sized(width: 0.02,),
            mediumText(title: title,fontSize: fontSize.toDouble(),color: AppColor.whiteColor,fontWeight:fontWeight ),
          ],
        ),
      ),
    );
  }
}

class TapIcon extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  final Color color ;
  final double size;
  const TapIcon({super.key,required this.iconData,this.color = AppColor.whiteColor,this.size = 20,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        iconData,
        color: color,
        size: size,
      ),
    );
  }
}

class TapImage extends StatelessWidget {
  final VoidCallback onTap;
  final String  imageData;
  final Color color ;
  final double width;
  final double height;
  const TapImage({super.key,required this.imageData,this.color = AppColor.whiteColor,this.width = 22, this.height = 22, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onTap,
      // child: Icon(
      //   iconData,
      //   color: color,
      //   size: size,
      // ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(imageData,
          color: color,
            width: width,
          height: height,




        ),
      ),
    );
  }
}

