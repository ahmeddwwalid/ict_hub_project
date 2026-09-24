import 'package:fpdart/fpdart.dart';
import 'package:ict_hub_project/core/error/failure.dart';
import 'package:ict_hub_project/features/products/domain/entity/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
      String category);
}
