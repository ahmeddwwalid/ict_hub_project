import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ict_hub_project/domain/repos/product_repo.dart';
import 'package:ict_hub_project/presentation/cubit/product_details/product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit({required this._repo})
    : super(ProductDetailsInitialState());

  final ProductRepo _repo;

  Future<void> getProductDetails({required String productId}) async {
    emit(ProductDetailsLoadingState());
    final result = await _repo.getProductDetails(productId: productId);
    result.fold(
      (failure) => emit(ProductDetailsFailureState(message: failure.msg)),
      (product) => emit(ProductDetailsSuccessState(product: product)),
    );
  }
}
