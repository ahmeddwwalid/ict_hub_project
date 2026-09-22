import 'package:ict_hub_project/features/products/data/data_source/product_remote_data_source.dart';
import 'package:ict_hub_project/features/products/domain/entity/product_entity.dart';
import 'package:ict_hub_project/features/products/domain/repository/product_repository.dart' as domain;

class ProductRepositoryImpl implements domain.ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ProductEntity>> fetchProducts() async {
    final models = await remoteDataSource.fetchProducts();
    return models.map((model) => model.toEntity()).toList();
  }
}
