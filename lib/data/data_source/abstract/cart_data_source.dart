import 'package:fpdart/fpdart.dart';
import 'package:ict_hub_project/core/network/error/failures.dart';

abstract class CartDataSource {
  Future<Either<Failure, Map<String, dynamic>>> getCart();

  Future<Either<Failure, Map<String, dynamic>>> addItem({
    required String productId,
    required int quantity,
  });

  Future<Either<Failure, Map<String, dynamic>>> updateItem({
    required String itemId,
    required int quantity,
  });

  Future<Either<Failure, Map<String, dynamic>>> removeItem({
    required String itemId,
  });
}
