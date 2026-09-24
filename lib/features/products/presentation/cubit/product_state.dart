part of 'product_cubit.dart';

@freezed
sealed class ProductState with _$ProductState {
  const factory ProductState.initial() = _Initial;
  const factory ProductState.loading() = _Loading;
  const factory ProductState.success(
    List<ProductEntity> products, {
    String? category,
  }) = _Success;
  const factory ProductState.error(String message) = _Error;
}
