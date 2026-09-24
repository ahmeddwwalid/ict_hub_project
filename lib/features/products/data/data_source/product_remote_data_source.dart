import 'package:dio/dio.dart';
import 'package:ict_hub_project/features/products/data/model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  /// The API pages its results (10 per page by default). The whole
  /// catalog is small, so ask for it in one page.
  static const _pageSize = 100;

  final Dio dio;

  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await dio.get(
        '/products',
        queryParameters: {'pageSize': _pageSize},
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to load products');
      }

      final items = (response.data as Map<String, dynamic>)['items'] as List;
      return items
          .map((product) =>
              ProductModel.fromJson(product as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('API Error: ${e.message}');
    }
  }
}
