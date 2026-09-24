import 'package:fpdart/fpdart.dart';
import 'package:ict_hub_project/core/network/error/failures.dart';
import 'package:ict_hub_project/data/data_source/abstract/cart_data_source.dart';
import 'package:ict_hub_project/domain/models/cart_model.dart';
import 'package:ict_hub_project/domain/repos/cart_repo.dart';

class CartRepoImpl implements CartRepo {
  CartRepoImpl({required this._dataSource});
  final CartDataSource _dataSource;

  @override
  Future<Either<Failure, CartResponse>> getCart() async {
    try {
      final response = await _dataSource.getCart();
      return response.map(CartResponse.fromJson);
    } catch (e) {
      return Left(DataMappingFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addItem({
    required String productId,
    int quantity = 1,
  }) async {
    final response = await _dataSource.addItem(
      productId: productId,
      quantity: quantity,
    );
    return response.map((_) => unit);
  }

  @override
  Future<Either<Failure, Unit>> updateItem({
    required String itemId,
    required int quantity,
  }) async {
    final response = await _dataSource.updateItem(
      itemId: itemId,
      quantity: quantity,
    );
    return response.map((_) => unit);
  }

  @override
  Future<Either<Failure, Unit>> removeItem({required String itemId}) async {
    final response = await _dataSource.removeItem(itemId: itemId);
    return response.map((_) => unit);
  }
}
