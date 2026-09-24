import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ict_hub_project/domain/models/products_model.dart';
import 'package:ict_hub_project/domain/repos/product_repo.dart';
import 'package:ict_hub_project/presentation/cubit/products/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this._repo}) : super(ProductInitialState());

  final ProductRepo _repo;

  /// Every product from the last unfiltered fetch, used to build the
  /// category list even while a category filter is active.
  List<ProductModel> _all = const [];

  List<String> get categories =>
      _all.expand((p) => p.categories ?? const <String>[]).toSet().toList()
        ..sort();

  /// Fetches every product, or only [category]'s (filtered by the API).
  Future<void> fetchProducts({String? category}) async {
    emit(ProductsLoadingState());
    final result = await _repo.getProducts(category: category);
    result.fold((failure) => emit(ProductsFailureState(message: failure.msg)), (
      response,
    ) {
      if (category == null) _all = response.items;
      emit(ProductsSuccessState(products: response.items, category: category));
    });
  }
}
