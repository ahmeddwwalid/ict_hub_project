import 'package:fpdart/fpdart.dart';
import 'package:ict_hub_project/core/network/api/api_consumer.dart';
import 'package:ict_hub_project/core/network/api/endpoints.dart';
import 'package:ict_hub_project/core/network/error/failures.dart';
import 'package:ict_hub_project/data/data_source/abstract/product_data_source.dart';

class ProductDataSourceImpl implements ProductDataSource {
  ProductDataSourceImpl({required this._apiConsumer});
  final ApiConsumer _apiConsumer;

  /// The API pages its results (10 per page by default). The whole
  /// catalog is small, so ask for it in one page.
  static const int _pageSize = 100;

  @override
  Future<Either<Failure, Map<String, dynamic>>> getProducts({
    String? category,
  }) {
    return _apiConsumer.get(
      path: Endpoints.products,
      queryParameters: {'pageSize': _pageSize, 'category': ?category},
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getProductDetails({
    required String productId,
  }) {
    return _apiConsumer.get(path: "${Endpoints.products}/$productId");
  }
}
