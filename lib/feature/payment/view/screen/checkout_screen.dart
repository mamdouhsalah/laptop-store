import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:state_mangement/core/manger/cubit/style_cubit.dart';
import 'package:state_mangement/feature/payment/view/screen/final_screen.dart';
import 'package:state_mangement/feature/product/model/modelProduct.dart';

class CheckoutScreen extends StatelessWidget {
  final List<ProductModel> products;

  const CheckoutScreen({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeCubit>().state;

    double subtotal = products.fold(0, (sum, item) => sum + item.price);
    double deliveryFee = 0;
    double discountPercent = 0;
    double discountValue = subtotal * discountPercent;
    double total = subtotal + deliveryFee - discountValue;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text("Checkout", style: TextStyle(color: theme.textColor)),
        backgroundColor: theme.backgroundColor,
        iconTheme: IconThemeData(color: theme.textColor),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              Text(
                "Order Summary",
                style: TextStyle(
                  color: theme.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 10.h),

              SizedBox(
                height: 110.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Container(
                      width: 80.w,
                      margin: EdgeInsets.only(right: 10.w),
                      decoration: BoxDecoration(
                        color: theme.cardcolor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.network(
                              product.image,
                              height: 60.h,
                              width: 60.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "\$${product.price}",
                            style: TextStyle(
                              color: theme.buttonColor,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 20.h),

              Text(
                "Payment Method",
                style: TextStyle(
                  color: theme.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: theme.buttonColor),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.credit_card, color: Colors.red),
                          SizedBox(width: 8.w),
                          Text(
                            "Mastercard",
                            style: TextStyle(color: theme.textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: theme.cardcolor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.paypal, color: Colors.blue),
                          SizedBox(width: 8.w),
                          Text(
                            "PayPal",
                            style: TextStyle(color: theme.textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 180.h),

              TextField(
                decoration: InputDecoration(
                  hintText: "Enter promo code",
                  suffixIcon: Icon(
                    Icons.check_circle,
                    color: theme.buttonColor,
                  ),
                  filled: true,
                  fillColor: theme.textColor.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Order Details
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal:",
                        style: TextStyle(color: theme.textColor),
                      ),
                      Text(
                        "\$${subtotal.toStringAsFixed(2)}",
                        style: TextStyle(color: theme.textColor),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Fee:",
                        style: TextStyle(color: theme.textColor),
                      ),
                      Text(
                        "\$${deliveryFee.toStringAsFixed(2)}",
                        style: TextStyle(color: theme.textColor),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discount:",
                        style: TextStyle(color: theme.textColor),
                      ),
                      Text(
                        "- \$${discountValue.toStringAsFixed(2)} (${(discountPercent * 100).toStringAsFixed(0)}%)",
                        style: TextStyle(color: theme.textColor),
                      ),
                    ],
                  ),
                  Divider(color: theme.textColor.withOpacity(0.3)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total:",
                        style: TextStyle(
                          color: theme.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                      Text(
                        "\$${total.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: theme.buttonColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),

      // Confirm Payment Button ثابت تحت الشاشة
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.w),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            minimumSize: Size(double.infinity, 50.h),
          ),
          onPressed: () {
            if (products.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ThankYouScreen()),
              );
            }
          },
          child: Text(
            "Confirm Payment",
            style: TextStyle(color: theme.backgroundColor, fontSize: 14.sp),
          ),
        ),
      ),
    );
  }
}
