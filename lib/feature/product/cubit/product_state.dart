part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class productInitial extends ProductState {}
final class productLoading extends ProductState {}
final class productSuccess extends ProductState {
  final List<ProductModel> lap;
  productSuccess({required this.lap});
}