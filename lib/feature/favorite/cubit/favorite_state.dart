
import 'package:state_mangement/feature/product/model/modelProduct.dart';

sealed class FavState {}

final class FavInitial extends FavState {}
final class FavLoadingState extends FavState {}
final class FavAddSuccessState extends FavState {}
final class FavDeleteSuccessState extends FavState {}
final class FavGetSuccessState extends FavState {

  final List<ProductModel> product;

  FavGetSuccessState({required this.product});
}