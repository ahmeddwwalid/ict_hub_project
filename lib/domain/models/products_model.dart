import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_model.freezed.dart';
part 'products_model.g.dart';

/// `GET /api/products` response: one page of products.
@freezed
abstract class ProductsResponse with _$ProductsResponse {
  const factory ProductsResponse({
    @Default([]) List<ProductModel> items,
    @Default(1) int page,
    @Default(0) int pageSize,
    @Default(0) int totalCount,
    @Default(false) bool hasNextPage,
  }) = _ProductsResponse;

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseFromJson(json);
}

/// A product, as returned in the list and by `GET /api/products/{id}`.
@freezed
abstract class ProductModel with _$ProductModel {
  const ProductModel._();

  const factory ProductModel({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'productCode') String? productCode,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'coverPictureUrl') String? coverPictureUrl,
    @JsonKey(name: 'productPictures') List<String>? productPictures,
    @JsonKey(name: 'categories') List<String>? categories,
    @JsonKey(name: 'price') double? price,
    @JsonKey(name: 'stock') int? stock,
    @JsonKey(name: 'weight') double? weight,
    @JsonKey(name: 'color') String? color,
    @JsonKey(name: 'discountPercentage') double? discountPercentage,
    @JsonKey(name: 'rating') double? rating,
    @JsonKey(name: 'reviewsCount') int? reviewsCount,
    @JsonKey(name: 'sellerId') String? sellerId,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  /// A product can belong to several categories or none.
  String get categoryLabel {
    final list = categories ?? const [];
    return list.isEmpty ? 'Uncategorized' : list.join(' · ');
  }
}
