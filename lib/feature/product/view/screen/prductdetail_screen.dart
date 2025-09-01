import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:state_mangement/core/manger/cubit/style_cubit.dart';
import 'package:state_mangement/feature/cart/cubit/cart_cubit.dart';
import 'package:state_mangement/feature/product/model/modelProduct.dart';
import 'package:state_mangement/feature/product/view/widget/buildDetailRow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: theme.cardcolor,

      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.buttonColor),
        centerTitle: true,
        title: Text(
          product.name,
          style: TextStyle(
            fontFamily: 'Playfair Display',
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: theme.textColor,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.images.isNotEmpty)
              CarouselSlider(
                options: CarouselOptions(
                  height: 250.h,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 700),
                  viewportFraction: 0.9,
                ),
                items: product.images.map((url) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                }).toList(),
              )
            else
              Image.network(
                product.image,
                height: 250.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

            SizedBox(height: 20.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: theme.textColor,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${product.price}",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: theme.buttonColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        product.status,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: product.status.toLowerCase() == "new"
                              ? theme.buttonColor
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  Text(
                    "Description",
                    style: TextStyle(
                      color: theme.textColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: theme.textColor.withOpacity(.5),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Text(
                    "Product Details",
                    style: TextStyle(
                      color: theme.textColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  DetailRow(title: "ID", value: product.id),
                  DetailRow(title: "Category", value: product.category),
                  DetailRow(title: "Company", value: product.company),
                  DetailRow(
                    title: "In Stock",
                    value: product.countInStock.toString(),
                  ),

                  SizedBox(height: 80.h),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff48d861),
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          onPressed: () {
            BlocProvider.of<CartCubit>(
              context,
            ).addCartCubit(productId: product.id);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(child: Text("${product.name} added to cart")),
              ),
            );
          },
          icon: Icon(Icons.add_shopping_cart, color: Colors.white, size: 22.sp),
          label: Text(
            "Add to Cart",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
