import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:state_mangement/core/manger/cubit/style_state.dart';
import 'package:state_mangement/feature/favorite/cubit/favorite_cubit.dart';
import 'package:state_mangement/feature/product/model/modelProduct.dart';
import 'package:state_mangement/feature/product/view/screen/prductdetail_screen.dart';

class SuccessFav extends StatelessWidget {
  final List<ProductModel> products;
  final ThemeState theme;

  const SuccessFav({super.key, required this.products, required this.theme});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(12.w),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          color: theme.cardcolor,
          margin: EdgeInsets.symmetric(vertical: 8.h),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product: product),
                ),
              );
            },
            child: ListTile(
              contentPadding: EdgeInsets.all(12.w),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  product.image,
                  width: 60.w,
                  height: 60.h,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                product.name,
                style: TextStyle(
                  color: theme.textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
              subtitle: Text(
                "\$${product.price.toStringAsFixed(2)}",
                style: TextStyle(
                  color: theme.buttonColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.redAccent, size: 24.sp),
                onPressed: () {
                  context.read<FavCubit>().deleteFavoriteCubit(id: product.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Removed from favorites"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
