import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:state_mangement/feature/cart/view/screen/cart_screen.dart';
import 'package:state_mangement/feature/favorite/view/screen/favorite_screen.dart';
import 'package:state_mangement/feature/profile/view/screen/profile_screen.dart';

class CustomDrawer extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;

  const CustomDrawer({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: backgroundColor),
            accountName: Text(
              "Eng. Mamdouh",
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            accountEmail: Text(
              "mamdouhsalah631@gmail.com",
              style: TextStyle(
                color: textColor.withOpacity(0.7),
                fontSize: 14.sp,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              radius: 30.r,
              backgroundColor: iconColor.withOpacity(0.2),
              child: Icon(Icons.person, color: iconColor, size: 40.sp),
            ),
          ),

          _buildDrawerItem(
            context,
            icon: Icons.home,
            title: "Home",
            onTap: () => Navigator.pop(context),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.person,
            title: "Profile",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.favorite,
            title: "Favorites",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoriteScreen()),
              );
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.add_card_outlined,
            title: "Payment",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),

          const Spacer(),

          ListTile(
            leading: Icon(Icons.logout, color: iconColor, size: 22.sp),
            title: Text(
              "Logout",
              style: TextStyle(color: textColor, fontSize: 16.sp),
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 22.sp),
      title: Text(
        title,
        style: TextStyle(color: textColor, fontSize: 16.sp),
      ),
      onTap: onTap,
    );
  }
}
