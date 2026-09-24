import 'package:fpdart/fpdart.dart';
import 'package:ict_hub_project/core/network/error/failures.dart';
import 'package:ict_hub_project/domain/models/products_model.dart';

abstract class ProductRepo {
  /// All products, or only those in [category] when given.
  Future<Either<Failure, ProductsResponse>> getProducts({String? category});

  Future<Either<Failure, ProductModel>> getProductDetails({
    required String productId,
  });
}
