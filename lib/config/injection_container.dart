import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ict_hub_project/core/cubit/theme/theme_cubit.dart';
import 'package:ict_hub_project/features/auth/data/repository/auth_repository_impl.dart';
import 'package:ict_hub_project/features/auth/domain/repository/auth_repository.dart';
import 'package:ict_hub_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ict_hub_project/features/products/data/data_source/product_remote_data_source.dart';
import 'package:ict_hub_project/features/products/data/repository/product_repository.dart';
import 'package:ict_hub_project/features/products/domain/repository/product_repository.dart'
    as domain;
import 'package:ict_hub_project/features/products/presentation/cubit/product_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  getIt.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: 'https://accessories-eshop.runasp.net/api',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    ),
  );

  getIt.registerSingleton<ProductRemoteDataSource>(
    ProductRemoteDataSourceImpl(getIt<Dio>()),
  );

  getIt.registerSingleton<domain.ProductRepository>(
    ProductRepositoryImpl(getIt<ProductRemoteDataSource>()),
  );
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  // Theme and auth are app-wide: the router and every screen share them.
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  getIt.registerLazySingleton<AuthCubit>(
      () => AuthCubit(getIt<AuthRepository>()));
  // Each tab gets its own ProductCubit so a category filter doesn't
  // leak into the full product list.
  getIt.registerFactory<ProductCubit>(
      () => ProductCubit(getIt<domain.ProductRepository>()));
}
