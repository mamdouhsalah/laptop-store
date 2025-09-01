import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_mangement/core/manger/cubit/style_cubit.dart';
import 'package:state_mangement/feature/cart/view/screen/cart_screen.dart';
import 'package:state_mangement/feature/product/cubit/product_cubit.dart';
import 'package:state_mangement/feature/product/view/widget/loadingWidget.dart';
import 'package:state_mangement/feature/product/view/widget/successWidget.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartScreen()),
          );
        },
        backgroundColor: theme.cardcolor,
        child: Icon(Icons.shopping_cart_rounded, color: theme.buttonColor),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is productSuccess) {
            return SuccessWidget(list: state.lap);
          }
          return LoadingWidget();
        },
      ),
    );
  }
}
