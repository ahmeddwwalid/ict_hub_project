import 'package:fpdart/fpdart.dart';
import 'package:ict_hub_project/core/network/api/api_consumer.dart';
import 'package:ict_hub_project/core/network/api/endpoints.dart';
import 'package:ict_hub_project/core/network/error/failures.dart';
import 'package:ict_hub_project/data/data_source/abstract/cart_data_source.dart';

class CartDataSourceImpl implements CartDataSource {
  CartDataSourceImpl({required this._apiConsumer});
  final ApiConsumer _apiConsumer;

  @override
  Future<Either<Failure, Map<String, dynamic>>> getCart() {
    return _apiConsumer.get(path: Endpoints.cart);
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> addItem({
    required String productId,
    required int quantity,
  }) {
    return _apiConsumer.post(
      path: Endpoints.cartItems,
      body: {'productId': productId, 'quantity': quantity},
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateItem({
    required String itemId,
    required int quantity,
  }) {
    return _apiConsumer.put(
      path: "${Endpoints.cartItems}/$itemId",
      body: {'id': itemId, 'quantity': quantity},
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> removeItem({
    required String itemId,
  }) {
    return _apiConsumer.delete(
      path: "${Endpoints.cartItems}/$itemId",
      body: {'id': itemId},
    );
  }
}
