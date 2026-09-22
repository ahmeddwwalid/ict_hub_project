import 'package:dio/dio.dart';
import 'package:ict_hub_project/features/products/data/model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await dio.get('/products');
      if (response.statusCode != 200) {
        throw Exception('Failed to load products');
      }

      final List<dynamic> data = response.data;
      return data
          .map((product) => ProductModel.fromJson(product as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('API Error: ${e.message}');
    }
  }
}
