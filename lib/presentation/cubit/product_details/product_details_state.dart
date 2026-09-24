import 'package:ict_hub_project/domain/models/products_model.dart';

sealed class ProductDetailsState {}

class ProductDetailsInitialState extends ProductDetailsState {}

class ProductDetailsLoadingState extends ProductDetailsState {}

class ProductDetailsSuccessState extends ProductDetailsState {
  final ProductModel product;

  ProductDetailsSuccessState({required this.product});
}

class ProductDetailsFailureState extends ProductDetailsState {
  final String message;

  ProductDetailsFailureState({required this.message});
}
