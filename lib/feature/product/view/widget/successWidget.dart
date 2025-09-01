import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_mangement/core/manger/cubit/style_cubit.dart';
import 'package:state_mangement/feature/cart/cubit/cart_cubit.dart';
import 'package:state_mangement/feature/favorite/cubit/favorite_cubit.dart';
import 'package:state_mangement/feature/product/cubit/product_cubit.dart';
import 'package:state_mangement/feature/product/model/modelProduct.dart';
import 'package:state_mangement/feature/product/view/screen/prductdetail_screen.dart';
import 'package:state_mangement/feature/product/view/widget/CategoryWidget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessWidget extends StatefulWidget {
  const SuccessWidget({super.key, required this.list});

  final List<ProductModel> list;

  @override
  State<SuccessWidget> createState() => _SuccessWidgetState();
}

class _SuccessWidgetState extends State<SuccessWidget> {
  List<String> categories = ["All", "Lenovo", "HP", "Dell", "Apple"];
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ThemeCubit>().state;

    return SingleChildScrollView(
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: TextField(
              style: TextStyle(color: theme.textColor, fontSize: 16.sp),
              decoration: InputDecoration(
                fillColor: theme.textColor.withOpacity(0.2),
                hintText: 'Search',
                prefixIcon: Icon(Icons.search, color: theme.buttonColor),
                hintStyle: TextStyle(color: theme.buttonColor.withOpacity(.3)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                filled: true,
              ),
              onChanged: (value) {
                context.read<ProductCubit>().search(value);
              },
            ),
          ),

          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is productSuccess && state.lap.isNotEmpty) {
                return Card(
                  color: theme.buttonColor,
                  elevation: 4.h,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 200.h,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        autoPlayAnimationDuration: const Duration(
                          milliseconds: 700,
                        ),
                        viewportFraction: 1,
                      ),
                      items: state.lap.map((product) {
                        return Image.network(
                          product.image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        );
                      }).toList(),
                    ),
                  ),
                );
              } else if (state is productLoading) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.h),
                    child: CircularProgressIndicator(color: theme.buttonColor),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          SizedBox(height: 16.h),

          SizedBox(
            height: 40.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categories.map((cat) {
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: CategoryChip(
                    title: cat,
                    selectedCategory: selectedCategory,
                    onSelected: (val) {
                      setState(() => selectedCategory = val);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 16.h),

          GridView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(), 
            padding: EdgeInsets.all(8.w),
            itemCount: widget.list.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              final product = widget.list[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailsScreen(product: product),
                    ),
                  );
                },
                child: Card(
                  color: theme.cardcolor,
                  elevation: 4.h,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16.r),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.network(
                                  product.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 10.h,
                                right: 10.w,
                                child: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<FavCubit>(
                                      context,
                                    ).addFavoriteCubit(id: product.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Center(
                                          child: Text('Added to favorite'),
                                        ),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: theme.buttonColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                color: theme.textColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${product.price}",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: theme.buttonColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  product.status,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: theme.buttonColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6.h),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.buttonColor
                                      .withOpacity(0.2),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                onPressed: () {
                                  BlocProvider.of<CartCubit>(
                                    context,
                                  ).addCartCubit(productId: product.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Center(
                                        child: Text('Added to cart'),
                                      ),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.add_shopping_cart,
                                  color: theme.buttonColor,
                                  size: 18.sp,
                                ),
                                label: Text(
                                  "Add",
                                  style: TextStyle(
                                    color: theme.buttonColor,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
