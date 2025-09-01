import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_mangement/core/manger/cubit/style_cubit.dart';
import 'package:state_mangement/feature/cart/cubit/cart_cubit.dart';
import 'package:state_mangement/feature/cart/cubit/cart_state.dart';
import 'package:state_mangement/feature/cart/view/widget/sucsses_widgetCart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: theme.backgroundColor,
        title: Text("My cart", style: TextStyle(color: theme.textColor)),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartGetState) {
            final products = state.product;
            return SucssesWidgetcart(products: products);
          }
          if (state is CartLoading) {
            return  Center(
              child: CircularProgressIndicator(color:theme.buttonColor),
            );
          }

          return const Center(child: Text("No items in cart"));
        },
      ),
    );
  }
}
