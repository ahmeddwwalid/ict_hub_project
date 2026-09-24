import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ict_hub_project/features/products/domain/entity/product_entity.dart';
import 'package:ict_hub_project/features/products/domain/repository/product_repository.dart';

part 'product_state.dart';
part 'product_cubit.freezed.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  ProductCubit(this.productRepository) : super(const ProductState.initial());

  /// Every product from the last unfiltered fetch, used to build the
  /// category list even while a category filter is active.
  List<ProductEntity> _all = const [];

  List<String> get categories =>
      (_all.expand((p) => p.categories).toSet().toList())..sort();

  Future<void> fetchProducts() async {
    emit(const ProductState.loading());
    final result = await productRepository.getProducts();
    result.fold(
      (failure) => emit(ProductState.error(failure.message)),
      (products) {
        _all = products;
        emit(ProductState.success(products));
      },
    );
  }

  Future<void> fetchByCategory(String category) async {
    emit(const ProductState.loading());
    final result = await productRepository.getProductsByCategory(category);
    result.fold(
      (failure) => emit(ProductState.error(failure.message)),
      (products) => emit(ProductState.success(products, category: category)),
    );
  }
}
