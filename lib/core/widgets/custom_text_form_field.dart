import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.hint,
    this.lable,
    this.validate,
    this.isPassword = false,
    this.icon,
    this.suffixIconOnPressed, required this.type,
  });
  final TextEditingController controller;
  final String? hint;
  final String? lable;
  final String? Function(String?)? validate;
  final bool isPassword;
  final IconData? icon;
  final VoidCallback? suffixIconOnPressed;
    final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.primary,
      validator: validate,
      obscureText: isPassword,
      keyboardType: type,
      decoration: InputDecoration(
      
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        hintText: hint,
        labelText: lable,
        suffixIcon: IconButton(
          onPressed: suffixIconOnPressed,
          icon: Icon(
            icon,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
