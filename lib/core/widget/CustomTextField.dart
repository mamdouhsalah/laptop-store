import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class customtextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String label;
  final IconData icon;
  final Color textColor;
  final Color buttonColor;
  final bool obscureText;
  final String? Function(String?)? validator;
  final VoidCallback? onToggleVisibility;
  final TextInputType keyboard;

  const customtextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.label,
    required this.icon,
    required this.textColor,
    required this.buttonColor,
    this.obscureText = false,
    this.validator,
    this.onToggleVisibility, required this.keyboard,
  });

  InputDecoration inputDecoration() {
    return InputDecoration(
      
      filled: true,
      fillColor: textColor.withOpacity(0.05),
      hintText: hint,
      label: Text(label, style: TextStyle(color: textColor)),
      hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
      prefixIcon: Icon(icon, color: buttonColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.r),
        borderSide: BorderSide(color: buttonColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: buttonColor.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.r),
        borderSide: BorderSide(color: buttonColor, width: 2.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.r),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide:  BorderSide(color: Colors.red, width: 2.w),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: textColor, fontSize: 17.sp),
      decoration: inputDecoration().copyWith(
        suffixIcon: onToggleVisibility != null
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: buttonColor,
                ),
                onPressed: onToggleVisibility,
              )
            : null,
      ),
      validator: validator,
    );
  }
}
