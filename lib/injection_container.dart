import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ict_hub_project/core/local_storage/base_local_storage.dart';
import 'package:ict_hub_project/core/network/api/api_consumer.dart';
import 'package:ict_hub_project/core/network/api/endpoints.dart';
import 'package:ict_hub_project/data/data_source/abstract/auth_data_source.dart';
import 'package:ict_hub_project/data/data_source/abstract/cart_data_source.dart';
import 'package:ict_hub_project/data/data_source/abstract/product_data_source.dart';
import 'package:ict_hub_project/data/data_source/impl/auth_data_source_impl.dart';
import 'package:ict_hub_project/data/data_source/impl/cart_data_source_impl.dart';
import 'package:ict_hub_project/data/data_source/impl/product_data_source_impl.dart';
import 'package:ict_hub_project/data/external/dio/dio_consumer.dart';
import 'package:ict_hub_project/data/external/dio/interceptor.dart';
import 'package:ict_hub_project/data/external/local_storage/shared_pref_impl.dart';
import 'package:ict_hub_project/data/repos/auth_repo_impl.dart';
import 'package:ict_hub_project/data/repos/cart_repo_impl.dart';
import 'package:ict_hub_project/data/repos/product_repo_impl.dart';
import 'package:ict_hub_project/domain/repos/auth_repo.dart';
import 'package:ict_hub_project/domain/repos/cart_repo.dart';
import 'package:ict_hub_project/domain/repos/product_repo.dart';
import 'package:ict_hub_project/presentation/cubit/auth/auth_cubit.dart';
import 'package:ict_hub_project/presentation/cubit/cart/cart_cubit.dart';
import 'package:ict_hub_project/presentation/cubit/product_details/product_details_cubit.dart';
import 'package:ict_hub_project/presentation/cubit/products/product_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future initDependencies() async {
  await InjectionHelper.injectExternal();
  InjectionHelper.injectDatasources();
  InjectionHelper.injectRepos();
  InjectionHelper.injectBlocs();
}

abstract class InjectionHelper {
  static Future<void> injectExternal() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    getIt.registerFactory<BaseLocalStorage>(
      () => SharedPrefsLocalStorageImpl(preferences: sharedPreferences),
    );
    getIt.registerSingleton<Dio>(Dio());
    getIt.registerSingleton<AppInterceptors>(
      AppInterceptors(localStorage: getIt()),
    );

    getIt.registerSingleton<ApiConsumer>(
      DioConsumer(
        baseUrl: Endpoints.baseUrl,
        client: getIt(),
        interceptors: [getIt<AppInterceptors>()],
      ),
    );
  }

  static void injectDatasources() {
    getIt.registerSingleton<AuthDataSource>(
      AuthDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
    );
    getIt.registerSingleton<ProductDataSource>(
      ProductDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
    );
    getIt.registerSingleton<CartDataSource>(
      CartDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
    );
  }

  static void injectRepos() {
    getIt.registerSingleton<AuthRepo>(
      AuthRepoImpl(
        dataSource: getIt<AuthDataSource>(),
        localStorage: getIt<BaseLocalStorage>(),
      ),
    );
    getIt.registerSingleton<ProductRepo>(
      ProductRepoImpl(dataSource: getIt<ProductDataSource>()),
    );
    getIt.registerSingleton<CartRepo>(
      CartRepoImpl(dataSource: getIt<CartDataSource>()),
    );
  }

  static void injectBlocs() {
    getIt.registerFactory<AuthCubit>(() => AuthCubit(repo: getIt<AuthRepo>()));
    getIt.registerFactory<ProductCubit>(
      () => ProductCubit(repo: getIt<ProductRepo>()),
    );
    getIt.registerFactory<ProductDetailsCubit>(
      () => ProductDetailsCubit(repo: getIt<ProductRepo>()),
    );
    getIt.registerFactory<CartCubit>(() => CartCubit(repo: getIt<CartRepo>()));
  }
}
