import 'package:ict_hub_project/domain/models/products_model.dart';

sealed class ProductState {}

class ProductInitialState extends ProductState {}

class ProductsLoadingState extends ProductState {}

class ProductsSuccessState extends ProductState {
  final List<ProductModel> products;

  /// The category these products were filtered by, if any.
  final String? category;

  ProductsSuccessState({required this.products, this.category});
}

class ProductsFailureState extends ProductState {
  final String message;

  ProductsFailureState({required this.message});
}
