import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String title;
  final double price;
  final List<String> categories;
  final String description;
  final String image;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.categories,
    required this.description,
    required this.image,
  });

  /// Display label; a product can belong to several categories or none.
  String get category =>
      categories.isEmpty ? 'Uncategorized' : categories.join(' · ');

  @override
  List<Object?> get props => [id, title, price, categories, description, image];
}
