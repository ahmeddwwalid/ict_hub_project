import 'package:fpdart/fpdart.dart';
import 'package:ict_hub_project/core/network/error/failures.dart';

abstract class ProductDataSource {
  Future<Either<Failure, Map<String, dynamic>>> getProducts({String? category});

  Future<Either<Failure, Map<String, dynamic>>> getProductDetails({
    required String productId,
  });
}
