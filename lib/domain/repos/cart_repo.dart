import 'package:fpdart/fpdart.dart';
import 'package:ict_hub_project/core/network/error/failures.dart';
import 'package:ict_hub_project/domain/models/cart_model.dart';

abstract class CartRepo {
  Future<Either<Failure, CartResponse>> getCart();

  Future<Either<Failure, Unit>> addItem({
    required String productId,
    int quantity = 1,
  });

  Future<Either<Failure, Unit>> updateItem({
    required String itemId,
    required int quantity,
  });

  Future<Either<Failure, Unit>> removeItem({required String itemId});
}
