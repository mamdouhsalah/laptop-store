import 'package:state_mangement/feature/product/model/modelProduct.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartSuccessState extends CartState {}

final class CartRemoveState extends CartState {
  final List<ProductModel> product;
  CartRemoveState({required this.product});
}

final class CartGetState extends CartState {
  final List<ProductModel> product;
  CartGetState({required this.product});
}
