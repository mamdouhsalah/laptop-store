import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:state_mangement/core/manger/cubit/style_cubit.dart';
import 'package:state_mangement/feature/home/view/screen/home_screen.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100.h),

            CircleAvatar(
              radius: 40.r,
              backgroundColor: theme.buttonColor,
              child: Icon(Icons.check, size: 50.sp, color: Colors.black),
            ),
            SizedBox(height: 20.h),

            Text(
              "Thank You!",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: theme.textColor,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Your order is being processed.",
              style: TextStyle(
                fontSize: 14.sp,
                color: theme.textColor.withOpacity(0.7),
              ),
            ),

            SizedBox(height: 30.h),

            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: theme.cardcolor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  _buildRow("Ref Number", "0005648846", theme),
                  SizedBox(height: 8.h),
                  _buildRow("Date", "29-08-2025", theme),
                  SizedBox(height: 8.h),
                  _buildRow("Method", "Mastercard ****5678", theme),
                  SizedBox(height: 8.h),
                  _buildRow(
                    "Total Paid",
                    "\$4123.98",
                    theme,
                    isBold: true,
                    valueColor: theme.buttonColor,
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                minimumSize: Size(double.infinity, 50.h),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              },
              child: Text(
                "Continue Shopping",
                style: TextStyle(color: Colors.black, fontSize: 14.sp),
              ),
            ),

            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
    String title,
    String value,
    theme, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: theme.textColor.withOpacity(0.6),
            fontSize: 14.sp,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: valueColor ?? theme.textColor,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
