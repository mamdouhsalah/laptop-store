import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_mangement/core/manger/cubit/style_cubit.dart';
import 'package:state_mangement/core/manger/cubit/style_state.dart';
import 'package:state_mangement/feature/authentication/cubit/auth_cubit.dart';
import 'package:state_mangement/feature/authentication/view/screen/login_screen.dart';
import 'package:state_mangement/feature/cart/cubit/cart_cubit.dart';
import 'package:state_mangement/feature/favorite/cubit/favorite_cubit.dart';
import 'package:state_mangement/feature/product/cubit/product_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductCubit()..getDataCubit()),
        BlocProvider(create: (context) => CartCubit()..getCartCubit()),
        BlocProvider(create: (context) => FavCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812), 
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  scaffoldBackgroundColor: state.backgroundColor,
                  cardColor: state.cardcolor,
                  appBarTheme: AppBarTheme(
                    backgroundColor: state.backgroundColor,
                    iconTheme: IconThemeData(color: state.textColor),
                    titleTextStyle: TextStyle(
                      color: state.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                home: const LoginScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
