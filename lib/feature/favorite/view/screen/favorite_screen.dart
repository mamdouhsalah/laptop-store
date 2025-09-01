import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:state_mangement/core/manger/cubit/style_cubit.dart';
import 'package:state_mangement/feature/favorite/cubit/favorite_cubit.dart';
import 'package:state_mangement/feature/favorite/cubit/favorite_state.dart';
import 'package:state_mangement/feature/favorite/view/widget/successFav.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Favorites',
          style: TextStyle(
            color: theme.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        iconTheme: IconThemeData(color: theme.textColor),
      ),
      body: BlocConsumer<FavCubit, FavState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FavLoadingState) {
            return Center(
              child: CircularProgressIndicator(color: theme.buttonColor),
            );
          }

          if (state is FavGetSuccessState && state.product.isNotEmpty) {
            return SuccessFav(products: state.product, theme: theme);
          }

          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80.sp,
                    color: theme.textColor.withOpacity(0.5),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "No favorite items yet ❤️",
                    style: TextStyle(
                      color: theme.textColor.withOpacity(0.6),
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Start exploring and add products you love!",
                    style: TextStyle(
                      color: theme.textColor.withOpacity(0.4),
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
