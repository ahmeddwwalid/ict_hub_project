import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ict_hub_project/features/products/data/data_source/product_remote_data_source.dart';
import 'package:ict_hub_project/features/products/data/repository/product_repository.dart';
import 'package:ict_hub_project/features/products/domain/repository/product_repository.dart' as domain;

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Dio
  getIt.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: 'https://accessories-eshop.runasp.net/api',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    ),
  );

  // Data Sources
  getIt.registerSingleton<ProductRemoteDataSource>(
    ProductRemoteDataSourceImpl(getIt<Dio>()),
  );

  // Repositories
  getIt.registerSingleton<domain.ProductRepository>(
    ProductRepositoryImpl(getIt<ProductRemoteDataSource>()),
  );
}
