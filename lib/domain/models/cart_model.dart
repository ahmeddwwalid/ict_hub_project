import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

/// `GET /api/cart` response.
@freezed
abstract class CartResponse with _$CartResponse {
  const CartResponse._();

  const factory CartResponse({
    @JsonKey(name: 'cartId') String? cartId,
    @JsonKey(name: 'cartItems') @Default([]) List<CartItemModel> cartItems,
  }) = _CartResponse;

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);

  int get itemsCount => cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + (item.totalPrice ?? 0));
}

@freezed
abstract class CartItemModel with _$CartItemModel {
  const factory CartItemModel({
    @JsonKey(name: 'itemId') required String itemId,
    @JsonKey(name: 'productId') String? productId,
    @JsonKey(name: 'productName') String? productName,
    @JsonKey(name: 'productCoverUrl') String? productCoverUrl,
    @JsonKey(name: 'productStock') int? productStock,
    @JsonKey(name: 'quantity') @Default(1) int quantity,
    @JsonKey(name: 'discountPercentage') double? discountPercentage,
    @JsonKey(name: 'basePricePerUnit') double? basePricePerUnit,
    @JsonKey(name: 'finalPricePerUnit') double? finalPricePerUnit,
    @JsonKey(name: 'totalPrice') double? totalPrice,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);
}
