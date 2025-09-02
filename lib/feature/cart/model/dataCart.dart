import 'package:dio/dio.dart';
import 'package:state_mangement/feature/product/model/modelProduct.dart';

class CartData {
  Dio dio = Dio();
  addCartData({required String productId}) async {
    var repo = await dio.post(
      'https://elwekala.onrender.com/cart/add',
      data: {
        "nationalId": "01210567022258",
        "productId": productId,
        "quantity": 1,
      },
    );
    print(repo.data);
  }

  getCartData() async {
    var repo = await dio.get(
      'https://elwekala.onrender.com/cart/allProducts',
      data: {"nationalId": "01210567022258"},
    );
    print(repo.data);
    List data = repo.data['products'];
    List<ProductModel> list = data
        .map((e) => ProductModel.fromJson(e))
        .toList();
        
    return list;
  }

  removeCartData({required String productId}) async {
    var repo = await dio.delete(
      'https://elwekala.onrender.com/cart/delete',

      data: {"nationalId": "01210567022258", "productId": productId},
    );
    print(repo.data);
    return getCartData();
  }
}
