import 'package:ict_hub_project/domain/models/cart_model.dart';

/// Every state carries the last loaded [cart] (if any), so the cart screen
/// keeps showing it while an update is in flight or after an error.
sealed class CartState {
  final CartResponse? cart;

  CartState({this.cart});
}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {
  CartLoadingState({super.cart});
}

class CartSuccessState extends CartState {
  CartSuccessState({required CartResponse super.cart});
}

/// A product was just added; a fresh [CartSuccessState] follows.
class CartItemAddedState extends CartState {
  final String productName;

  CartItemAddedState({super.cart, required this.productName});
}

class CartFailureState extends CartState {
  final String message;

  CartFailureState({super.cart, required this.message});
}
