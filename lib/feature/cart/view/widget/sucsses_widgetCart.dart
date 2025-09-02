import 'package:flutter/material.dart';
import 'package:state_mangement/core/manger/cubit/style_cubit.dart';
import 'package:state_mangement/feature/payment/view/screen/checkout_screen.dart';
import 'package:state_mangement/feature/product/model/modelProduct.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SucssesWidgetcart extends StatefulWidget {
  final List<ProductModel> products;
  const SucssesWidgetcart({super.key, required this.products});

  @override
  State<SucssesWidgetcart> createState() => _SucssesWidgetcartState();
}

class _SucssesWidgetcartState extends State<SucssesWidgetcart> {
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeCubit>().state;

    final products = widget.products;

    double total = products.fold(0, (sum, item) => sum + (item.price));

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(12.sp),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                color: theme.cardcolor,
                margin: EdgeInsets.symmetric(vertical: 8.h),
                elevation: 2.h,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          product.image,
                          height: 70.h,
                          width: 70.w,

                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: theme.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              product.status,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: theme.textColor.withOpacity(0.5),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "\$${product.price}",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: theme.buttonColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: theme.buttonColor,
                            ),
                          ),
                          Text(
                            "1",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: theme.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: theme.buttonColor,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            products.removeAt(index);
                          });
                        },
                        icon: const Icon(Icons.close, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CheckoutScreen(products: products),
                  ),
                );
              },

              child: Text(
                "Checkout for \$${total.toStringAsFixed(2)}",
                style: TextStyle(color: theme.backgroundColor, fontSize: 16.sp),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
