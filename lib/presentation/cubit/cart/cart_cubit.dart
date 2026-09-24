import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ict_hub_project/domain/models/products_model.dart';
import 'package:ict_hub_project/domain/repos/cart_repo.dart';
import 'package:ict_hub_project/presentation/cubit/cart/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required this._repo}) : super(CartInitialState());

  final CartRepo _repo;

  Future<void> getCart() async {
    emit(CartLoadingState(cart: state.cart));
    final result = await _repo.getCart();
    result.fold(
      (failure) =>
          emit(CartFailureState(cart: state.cart, message: failure.msg)),
      (cart) => emit(CartSuccessState(cart: cart)),
    );
  }

  Future<void> addItem({
    required ProductModel product,
    int quantity = 1,
  }) async {
    final productId = product.id;
    if (productId == null) return;

    emit(CartLoadingState(cart: state.cart));
    final result = await _repo.addItem(
      productId: productId,
      quantity: quantity,
    );
    await result.fold(
      (failure) async =>
          emit(CartFailureState(cart: state.cart, message: failure.msg)),
      (_) async {
        emit(
          CartItemAddedState(
            cart: state.cart,
            productName: product.name ?? 'Item',
          ),
        );
        await getCart();
      },
    );
  }

  /// Sets an item's quantity; zero or less removes it.
  Future<void> updateQuantity({
    required String itemId,
    required int quantity,
  }) async {
    if (quantity <= 0) return removeItem(itemId: itemId);

    emit(CartLoadingState(cart: state.cart));
    final result = await _repo.updateItem(itemId: itemId, quantity: quantity);
    await result.fold(
      (failure) async =>
          emit(CartFailureState(cart: state.cart, message: failure.msg)),
      (_) => getCart(),
    );
  }

  Future<void> removeItem({required String itemId}) async {
    emit(CartLoadingState(cart: state.cart));
    final result = await _repo.removeItem(itemId: itemId);
    await result.fold(
      (failure) async =>
          emit(CartFailureState(cart: state.cart, message: failure.msg)),
      (_) => getCart(),
    );
  }

  /// Forgets the cart, e.g. on logout.
  void clear() => emit(CartInitialState());
}
