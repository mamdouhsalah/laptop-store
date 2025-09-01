import 'package:dio/dio.dart';
import 'package:state_mangement/feature/product/model/modelProduct.dart';

class ProductData {
  final Dio dio = Dio();

  getDatalap() async {
    var response = await dio.get(
      'https://elwekala.onrender.com/product/Laptops',
    );
    List data = response.data['product'];
    List<ProductModel> list = data
        .map((e) => ProductModel.fromJson(e))
        .toList();

    return list;
  }
}
