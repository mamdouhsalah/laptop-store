import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:state_mangement/core/manger/cubit/style_cubit.dart';
import 'package:state_mangement/feature/cart/view/screen/cart_screen.dart';
import 'package:state_mangement/feature/favorite/view/screen/favorite_screen.dart';
import 'package:state_mangement/feature/home/view/widget/custom_drawer.dart';
import 'package:state_mangement/feature/product/view/screen/product_screen.dart';
import 'package:state_mangement/feature/profile/view/screen/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = [
    const ProductScreen(),
    const CartScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0.h,
        elevation: 0.h,
        backgroundColor: theme.backgroundColor,
        title: Text(
          'Xenon Store',
          style: TextStyle(
            fontSize: 28.sp,
            color: theme.textColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Playfair Display',
          ),
        ),
        actions: [
          Card(
            color: theme.textColor,
            elevation: 0.h,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.dark_mode, size: 22.sp),
                  color: theme.backgroundColor,
                  onPressed: () {
                    context.read<ThemeCubit>().setDarkTheme();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.light_mode, size: 22.sp),
                  color: theme.buttonColor,
                  onPressed: () {
                    context.read<ThemeCubit>().setLightTheme();
                  },
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  color: theme.textColor,
                  size: 28.sp,
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: CustomDrawer(
        backgroundColor: theme.backgroundColor,
        textColor: theme.textColor,
        iconColor: theme.buttonColor,
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.backgroundColor,
        selectedItemColor: theme.buttonColor,
        unselectedItemColor: theme.buttonColor.withOpacity(.25),
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 22.sp),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined, size: 22.sp),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, size: 22.sp),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 22.sp),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
