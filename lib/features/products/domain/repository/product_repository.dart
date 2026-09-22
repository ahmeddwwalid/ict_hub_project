import 'package:ict_hub_project/features/products/domain/entity/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> fetchProducts();
}
