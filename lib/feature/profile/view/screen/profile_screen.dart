import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:state_mangement/core/manger/cubit/style_cubit.dart';
import 'package:state_mangement/feature/authentication/view/screen/login_screen.dart';
import 'package:state_mangement/feature/cart/view/screen/cart_screen.dart';
import 'package:state_mangement/feature/profile/view/screen/editProfile_screen.dart';
import 'package:state_mangement/feature/profile/view/widget/buildOption_Widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 70.r,
                  backgroundImage: const NetworkImage(""),
                  backgroundColor: theme.cardcolor,
                ),
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: theme.buttonColor,
                  child: Icon(Icons.edit, color: Colors.white, size: 18.sp),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              "Eng. Mamdouh",
              style: TextStyle(
                color: theme.textColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "mamdouhsalah631@gmail.com",
              style: TextStyle(
                color: theme.textColor.withOpacity(0.7),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 24.h),

            buildOption(
              context,
              icon: Icons.shopping_bag_outlined,
              title: "My Orders",
              theme: theme,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
            ),

            buildOption(
              context,
              icon: Icons.credit_card,
              title: "Payment Methods",
              theme: theme,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('will be implemented soon'),
                  ),
                );
              },
            ),
            buildOption(
              context,
              icon: Icons.edit_calendar_sharp,
              title: "Edit Profile",
              theme: theme,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditprofileScreen(),
                  ),
                );
              },
            ),
            buildOption(
              context,
              icon: Icons.logout,
              title: "Logout",
              theme: theme,
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
