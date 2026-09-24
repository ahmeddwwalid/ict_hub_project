import 'package:fpdart/fpdart.dart';
import 'package:ict_hub_project/core/network/error/failures.dart';
import 'package:ict_hub_project/data/data_source/abstract/product_data_source.dart';
import 'package:ict_hub_project/domain/models/products_model.dart';
import 'package:ict_hub_project/domain/repos/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  ProductRepoImpl({required this._dataSource});
  final ProductDataSource _dataSource;

  @override
  Future<Either<Failure, ProductsResponse>> getProducts({
    String? category,
  }) async {
    try {
      final response = await _dataSource.getProducts(category: category);
      return response.map(ProductsResponse.fromJson);
    } catch (e) {
      return Left(DataMappingFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getProductDetails({
    required String productId,
  }) async {
    try {
      final response = await _dataSource.getProductDetails(
        productId: productId,
      );
      return response.map(ProductModel.fromJson);
    } catch (e) {
      return Left(DataMappingFailure(msg: e.toString()));
    }
  }
}
