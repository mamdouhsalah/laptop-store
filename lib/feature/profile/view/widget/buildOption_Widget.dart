
  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';


Widget buildOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required dynamic theme,
    required VoidCallback onTap,
  }) {
    return Card(
      margin:  EdgeInsets.symmetric(vertical: 8.h),
      color: theme.cardcolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: ListTile(
        leading: Icon(icon, color: theme.buttonColor),
        title: Text(
          title,
          style: TextStyle(color: theme.textColor, fontWeight: FontWeight.w600),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.sp,
          color: theme.textColor.withOpacity(0.5),
        ),
        onTap: onTap,
      ),
    );
  }