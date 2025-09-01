import 'package:bloc/bloc.dart';
import 'package:state_mangement/feature/cart/cubit/cart_state.dart';
import 'package:state_mangement/feature/cart/model/dataCart.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  CartData cart = CartData();

  addCartCubit({required String productId}) async {
    await cart.addCartData(productId: productId);
    emit(CartSuccessState());
    getCartCubit();
  }

  getCartCubit() async {
    emit(CartLoading());
    var data = await cart.getCartData();
    emit(CartGetState(product: data));
  }

  removeCartCubit({required String productId}) async {
    await cart.removeCartData(productId: productId);
    var data = await cart.getCartData();
    emit(CartRemoveState(product: data)); 
  }
}
