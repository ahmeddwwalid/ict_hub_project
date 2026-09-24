import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ict_hub_project/config/injection_container.dart';
import 'package:ict_hub_project/core/error/failure.dart';
import 'package:ict_hub_project/features/auth/data/repository/auth_repository_impl.dart';
import 'package:ict_hub_project/features/auth/domain/entity/user_entity.dart';
import 'package:ict_hub_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ict_hub_project/features/products/data/model/product_model.dart';
import 'package:ict_hub_project/features/products/domain/entity/product_entity.dart';
import 'package:ict_hub_project/features/products/domain/repository/product_repository.dart';
import 'package:ict_hub_project/features/products/presentation/cubit/product_cubit.dart';
import 'package:ict_hub_project/main.dart';

const _products = [
  ProductEntity(
    id: '1',
    title: 'Headphones',
    price: 59.99,
    categories: ['electronics'],
    description: 'Wireless',
    image: '',
  ),
  ProductEntity(
    id: '2',
    title: 'Backpack',
    price: 89.5,
    categories: ['bags', 'leather'],
    description: 'Leather',
    image: '',
  ),
];

class _FakeProductRepository implements ProductRepository {
  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async =>
      right(_products);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
          String category) async =>
      right(_products.where((p) => p.categories.contains(category)).toList());
}

void main() {
  group('AuthCubit', () {
    test('login emits loading then success', () async {
      final cubit = AuthCubit(AuthRepositoryImpl());
      final states = expectLater(
        cubit.stream,
        emitsInOrder([
          const AuthState.loading(),
          const AuthState.success(UserEntity(name: 'a', email: 'a@b.com')),
        ]),
      );
      await cubit.login('a@b.com', 'secret1');
      await states;
      expect(cubit.isAuthenticated, isTrue);
    });

    test('signup sends OTP, wrong code errors, right code succeeds', () async {
      final cubit = AuthCubit(AuthRepositoryImpl());

      await cubit.signup('Ahmed', 'a@b.com', 'secret1');
      expect(cubit.state, const AuthState.otpSent('a@b.com'));

      await cubit.verifyOtp('a@b.com', '0000');
      expect(cubit.state, isA<AuthState>());
      expect(cubit.isAuthenticated, isFalse);
      expect(
        cubit.state.maybeMap(error: (_) => true, orElse: () => false),
        isTrue,
      );

      await cubit.verifyOtp('a@b.com', AuthRepositoryImpl.mockOtp);
      expect(
        cubit.state,
        const AuthState.success(UserEntity(name: 'Ahmed', email: 'a@b.com')),
      );

      await cubit.logout();
      expect(cubit.isAuthenticated, isFalse);
    });
  });

  test('ProductModel parses an item from /api/products', () {
    final model = ProductModel.fromJson({
      'id': '532e50d4-24e5-431a-9984-506b4a9b2d6e',
      'name': 'Ruby Red Heart Solitaire Charm',
      'description': 'Vivid crimson heart-cut gemstone.',
      'coverPictureUrl': 'https://example.com/ruby.jpg',
      'productPictures': null,
      'price': 2100.00,
      'stock': 18,
      'categories': ['charms', 'jewelry'],
    });
    final entity = model.toEntity();
    expect(entity.title, 'Ruby Red Heart Solitaire Charm');
    expect(entity.price, 2100.0);
    expect(entity.image, 'https://example.com/ruby.jpg');
    expect(entity.category, 'charms · jewelry');

    final bare = ProductModel.fromJson(
        {'id': 'x', 'name': 'Bare', 'price': 5, 'categories': []}).toEntity();
    expect(bare.category, 'Uncategorized');
    expect(bare.description, '');
  });

  group('ProductCubit', () {
    test('fetchProducts loads everything and exposes categories', () async {
      final cubit = ProductCubit(_FakeProductRepository());
      await cubit.fetchProducts();
      expect(cubit.state, const ProductState.success(_products));
      expect(cubit.categories, ['bags', 'electronics', 'leather']);
    });

    test('fetchByCategory filters and remembers the category', () async {
      final cubit = ProductCubit(_FakeProductRepository());
      await cubit.fetchProducts();
      await cubit.fetchByCategory('leather');
      expect(
        cubit.state,
        ProductState.success([_products[1]], category: 'leather'),
      );
      // The chip list still shows every category while filtered.
      expect(cubit.categories, ['bags', 'electronics', 'leather']);
    });
  });

  testWidgets('router: login -> products, logout -> login', (tester) async {
    await getIt.reset();
    await initDependencies();
    getIt.allowReassignment = true;
    getIt.registerSingleton<ProductRepository>(_FakeProductRepository());

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);

    final auth = getIt<AuthCubit>();
    auth.login('a@b.com', 'secret1');
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('Headphones'), findsOneWidget);
    expect(find.text('Backpack'), findsOneWidget);

    await auth.logout();
    await tester.pumpAndSettle();
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
  });
}
