import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:state_mangement/feature/product/model/dataProduct.dart';
import 'package:state_mangement/feature/product/model/modelProduct.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(productInitial());

  final ProductData lap = ProductData();

  List<ProductModel> allProducts = [];

 getDataCubit() async {
    emit(productLoading());
    final products = await lap.getDatalap();
    allProducts = products; 
    emit(productSuccess(lap: products));
  }

  void search(String query) {
    if (query.isEmpty) {
      emit(productSuccess(lap: allProducts)); 
    } else {
      final filtered = allProducts
          .where((item) =>
              item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(productSuccess(lap: filtered));
    }
  }
  void filterByCategory(String category) {
  if (category == "All") {
    emit(productSuccess(lap: allProducts));
  } else {
    final filtered = allProducts
        .where((item) => item.company.toLowerCase() == category.toLowerCase())
        .toList();
    emit(productSuccess(lap: filtered));
  }
}
remove(){
}

  
}
