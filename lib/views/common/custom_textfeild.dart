import 'package:flutter/material.dart';
import '../../core/presentation/app_colors.dart';
import '../../core/presentation/font_manager.dart';




class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool isSuffixIcon;
  final Widget? suffixIcon;
  final bool isPasswordField;
  final FormFieldValidator validate;
  final bool isDense ;
  final int maxLine ;
  final Function(String) ? onChanged ;
  final VoidCallback ontap;
  const CustomTextField(
      {super.key, required this.controller,
      required this.hintText,
        this.isSuffixIcon = false,
      this.keyboardType = TextInputType.text,
        this.isPasswordField = false,
        this.ontap  = _emptyOnTap,
        this.suffixIcon,
      required this.validate,
        this.isDense =false,
        this.onChanged,
        this.maxLine = 1
      });
  static void _emptyOnTap() {}
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  var _hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPasswordField ? _hidePassword : false,
      maxLines: widget.maxLine,
      onTap: widget.ontap,
      onChanged: widget.onChanged,
      obscuringCharacter: '*',
      cursorColor: AppColor.primaryColor,
      validator: widget.validate,
      style:  TextStyle(color: AppColor.blackColor.withOpacity(0.78), fontWeight: FontWeight.bold,fontSize: 14, fontFamily: FontConstants.fontFamily),
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        suffix: widget.isSuffixIcon ? widget.suffixIcon : SizedBox.shrink(),
        contentPadding: const EdgeInsets.only(left: 16, top: 0, bottom: 0),

        isDense: widget.isDense,
        hintText: widget.hintText,
        suffixIcon: widget.isPasswordField
      ? IconButton(
      icon: Icon(_hidePassword
      ? Icons.remove_red_eye
          : Icons.remove_red_eye, color: AppColor.primaryColor, size: 20.0,),
      onPressed: () {
        setState(() {
          _hidePassword = !_hidePassword;
        });
      },
    )
        : widget.suffixIcon ?? SizedBox.shrink(),
        labelStyle: TextStyle(
            color: AppColor.blackColor.withOpacity(0.5),
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            fontFamily: FontConstants.fontFamily

        ),
        hintStyle:  TextStyle(
            color: AppColor.blackColor.withOpacity(0.5),
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            fontFamily: FontConstants.fontFamily

        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColor.blackColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColor.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColor.errorColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColor.blackColor, width: 1),
        ),
      ),
    );
  }
}







