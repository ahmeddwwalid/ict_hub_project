import 'package:ict_hub_project/features/products/domain/entity/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

/// One item of the `/api/products` response's `items` array.
@JsonSerializable()
class ProductModel {
  final String id;
  final String name;
  final double price;
  @JsonKey(defaultValue: <String>[])
  final List<String> categories;
  final String? description;
  final String? coverPictureUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.categories,
    this.description,
    this.coverPictureUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductEntity toEntity() => ProductEntity(
        id: id,
        title: name,
        price: price,
        categories: categories,
        description: description ?? '',
        image: coverPictureUrl ?? '',
      );
}
