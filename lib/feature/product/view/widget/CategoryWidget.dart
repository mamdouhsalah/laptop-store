import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_mangement/core/manger/cubit/style_cubit.dart';
import 'package:state_mangement/feature/product/cubit/product_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryChip extends StatelessWidget {
  final String title;
  final String selectedCategory;
  final Function(String) onSelected;

  const CategoryChip({
    super.key,
    required this.title,
    required this.selectedCategory,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ThemeCubit>().state;

    final bool isSelected = title == selectedCategory;

    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: ChoiceChip(
        backgroundColor: theme.buttonColor,
        label: Text(
          title,
          style: TextStyle(color: isSelected ? theme.textColor : Colors.black),
        ),
        selected: isSelected,
        selectedColor: theme.cardcolor,
        shape: const StadiumBorder(),
        onSelected: (_) {
          onSelected(title);
          context.read<ProductCubit>().filterByCategory(title);
        },
      ),
    );
  }
}
