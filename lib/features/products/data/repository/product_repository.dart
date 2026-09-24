import 'package:fpdart/fpdart.dart';
import 'package:ict_hub_project/core/error/failure.dart';
import 'package:ict_hub_project/features/products/data/data_source/product_remote_data_source.dart';
import 'package:ict_hub_project/features/products/domain/entity/product_entity.dart';
import 'package:ict_hub_project/features/products/domain/repository/product_repository.dart'
    as domain;

class ProductRepositoryImpl implements domain.ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final models = await remoteDataSource.fetchProducts();
      return right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return left(Failure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
      String category) async {
    final result = await getProducts();
    return result.map(
        (products) =>
            products.where((p) => p.categories.contains(category)).toList());
  }
}
