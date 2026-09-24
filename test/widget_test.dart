import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ict_hub_project/app/app_router.dart';
import 'package:ict_hub_project/core/constant/local_keys.dart';
import 'package:ict_hub_project/domain/models/products_model.dart';
import 'package:ict_hub_project/injection_container.dart';
import 'package:ict_hub_project/main.dart';
import 'package:ict_hub_project/presentation/cubit/auth/auth_cubit.dart';
import 'package:ict_hub_project/presentation/cubit/auth/auth_state.dart';
import 'package:ict_hub_project/presentation/cubit/cart/cart_cubit.dart';
import 'package:ict_hub_project/presentation/cubit/cart/cart_state.dart';
import 'package:ict_hub_project/presentation/cubit/products/product_cubit.dart';
import 'package:ict_hub_project/presentation/cubit/products/product_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Answers Dio requests from canned responses keyed by "METHOD path",
/// and records every request so tests can inspect headers and bodies.
class FakeApi implements HttpClientAdapter {
  final requests = <RequestOptions>[];
  final _routes = <String, (int, Object?)>{};

  void on(String method, String path, int status, [Object? body]) {
    _routes['$method $path'] = (status, body);
  }

  RequestOptions last(String method, String path) =>
      requests.lastWhere((r) => r.method == method && r.path == path);

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    final route = _routes['${options.method} ${options.path}'];
    if (route == null) return ResponseBody.fromString('', 404);
    final (status, body) = route;
    if (body == null) return ResponseBody.fromString('', status);
    return ResponseBody.fromString(
      jsonEncode(body),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

const _products = {
  'items': [
    {
      'id': 'p1',
      'name': 'Ruby Charm',
      'price': 2100.00,
      'stock': 18,
      'categories': ['charms', 'jewelry'],
      'coverPictureUrl': '',
    },
    {
      'id': 'p2',
      'name': 'Canvas Bag',
      'price': 45,
      'stock': 3,
      'categories': ['bags'],
      'coverPictureUrl': '',
    },
  ],
  'page': 1,
  'pageSize': 100,
  'totalCount': 2,
  'hasNextPage': false,
};

Map<String, Object?> _cartWith({int quantity = 1}) => {
  'cartId': 'c1',
  'cartItems': [
    {
      'itemId': 'i1',
      'productId': 'p1',
      'productName': 'Ruby Charm',
      'productCoverUrl': '',
      'productStock': 18,
      'quantity': quantity,
      'finalPricePerUnit': 2100.0,
      'totalPrice': 2100.0 * quantity,
    },
  ],
};

late FakeApi api;
late SharedPreferences prefs;

/// Fresh DI graph over [FakeApi] and in-memory prefs.
Future<void> setUpApp([Map<String, Object> storedValues = const {}]) async {
  SharedPreferences.setMockInitialValues(storedValues);
  await getIt.reset();
  await initDependencies();
  api = FakeApi();
  getIt<Dio>().httpClientAdapter = api;
  prefs = await SharedPreferences.getInstance();
}

void main() {
  group('auth', () {
    setUp(setUpApp);

    test('login saves the token and later requests send it', () async {
      api.on('POST', 'auth/login', 200, {
        'accessToken': 'tok-123',
        'refreshToken': 'ref-456',
        'expiresAtUtc': '2026-10-01T00:00:00Z',
      });
      api.on('GET', 'cart', 200, {'cartId': 'c1', 'cartItems': []});

      final auth = getIt<AuthCubit>();
      await auth.login(email: 'a@b.com', password: 'secret1');

      expect(auth.state, isA<LoginSuccessState>());
      expect(api.last('POST', 'auth/login').data, {
        'email': 'a@b.com',
        'password': 'secret1',
      });
      expect(prefs.getString(LocalKeys.accessToken), 'tok-123');
      expect(prefs.getString(LocalKeys.refreshToken), 'ref-456');

      await getIt<CartCubit>().getCart();
      expect(
        api.last('GET', 'cart').headers['Authorization'],
        'Bearer tok-123',
      );
    });

    test('login failure shows the API validation message', () async {
      api.on('POST', 'auth/login', 400, {
        'statusCode': 400,
        'message': 'One or more errors occurred!',
        'errors': {
          'password': ['Password is required.'],
        },
      });

      final auth = getIt<AuthCubit>();
      await auth.login(email: 'a@b.com', password: 'x');

      final state = auth.state;
      expect(state, isA<AuthFailureState>());
      expect((state as AuthFailureState).message, 'Password is required.');
      expect(prefs.getString(LocalKeys.accessToken), isNull);
    });

    test('register splits the full name for the API', () async {
      api.on('POST', 'auth/register', 200);

      final auth = getIt<AuthCubit>();
      await auth.register(
        fullName: ' Ahmed  Walid Hassan ',
        email: 'a@b.com',
        password: 'secret1',
      );

      expect(auth.state, isA<RegisterSuccessState>());
      expect((auth.state as RegisterSuccessState).email, 'a@b.com');
      expect(api.last('POST', 'auth/register').data, {
        'firstName': 'Ahmed',
        'lastName': 'Walid Hassan',
        'email': 'a@b.com',
        'password': 'secret1',
      });
    });

    test('verify email sends the code', () async {
      api.on('POST', 'auth/verify-email', 200, {'message': 'ok'});

      final auth = getIt<AuthCubit>();
      await auth.verifyEmail(email: 'a@b.com', otp: '123456');

      expect(auth.state, isA<VerifyEmailSuccessState>());
      expect(api.last('POST', 'auth/verify-email').data, {
        'email': 'a@b.com',
        'otp': '123456',
      });
    });

    test('a 401 drops the saved token but keeps onboarding done', () async {
      await prefs.setBool(LocalKeys.isOpen, true);
      await prefs.setString(LocalKeys.accessToken, 'expired');
      api.on('GET', 'cart', 401);

      final cart = getIt<CartCubit>();
      await cart.getCart();

      expect(cart.state, isA<CartFailureState>());
      expect((cart.state as CartFailureState).message, 'Unauthorized');
      expect(prefs.getString(LocalKeys.accessToken), isNull);
      expect(prefs.getBool(LocalKeys.isOpen), isTrue);
    });
  });

  group('cart', () {
    setUp(() => setUpApp({LocalKeys.accessToken: 'tok'}));

    test('add item posts it, then reloads the cart', () async {
      api.on('POST', 'cart/items', 200, {'message': 'Added', 'id': 'i1'});
      api.on('GET', 'cart', 200, _cartWith());

      final cart = getIt<CartCubit>();
      final states = <CartState>[];
      final sub = cart.stream.listen(states.add);
      final product = ProductModel.fromJson(
        (_products['items'] as List).first as Map<String, dynamic>,
      );

      await cart.addItem(product: product);
      await sub.cancel();

      expect(api.last('POST', 'cart/items').data, {
        'productId': 'p1',
        'quantity': 1,
      });
      expect(
        states.whereType<CartItemAddedState>().single.productName,
        'Ruby Charm',
      );
      final loaded = cart.state as CartSuccessState;
      expect(loaded.cart!.cartItems.single.itemId, 'i1');
      expect(loaded.cart!.itemsCount, 1);
      expect(loaded.cart!.totalPrice, 2100.0);
    });

    test('quantity changes PUT the item; zero DELETEs it', () async {
      api.on('PUT', 'cart/items/i1', 200, {'message': 'Updated'});
      api.on('DELETE', 'cart/items/i1', 200);
      api.on('GET', 'cart', 200, _cartWith(quantity: 3));

      final cart = getIt<CartCubit>();
      await cart.updateQuantity(itemId: 'i1', quantity: 3);
      expect(api.last('PUT', 'cart/items/i1').data, {
        'id': 'i1',
        'quantity': 3,
      });
      expect((cart.state as CartSuccessState).cart!.itemsCount, 3);

      await cart.updateQuantity(itemId: 'i1', quantity: 0);
      expect(api.requests.any((r) => r.method == 'DELETE'), isTrue);
    });
  });

  group('products', () {
    setUp(setUpApp);

    test('fetch all, then filter by category on the server', () async {
      api.on('GET', 'products', 200, _products);

      final cubit = getIt<ProductCubit>();
      await cubit.fetchProducts();
      expect((cubit.state as ProductsSuccessState).products, hasLength(2));
      expect(cubit.categories, ['bags', 'charms', 'jewelry']);
      expect(api.last('GET', 'products').queryParameters, {'pageSize': 100});

      await cubit.fetchProducts(category: 'bags');
      expect(api.last('GET', 'products').queryParameters, {
        'pageSize': 100,
        'category': 'bags',
      });
      expect((cubit.state as ProductsSuccessState).category, 'bags');
      // Chips still list every category while filtered.
      expect(cubit.categories, ['bags', 'charms', 'jewelry']);
    });
  });

  group('app flow', () {
    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(MyApp(router: AppRouter.createRouter()));
      await tester.pumpAndSettle();
    }

    testWidgets('first launch: onboarding, then login; isOpen saved', (
      tester,
    ) async {
      await setUpApp();
      await pumpApp(tester);

      // No intro/splash screen: the app opens straight on onboarding.
      expect(find.text('ICT Hub Store'), findsNothing);
      expect(find.text('Discover Accessories'), findsOneWidget);
      await tester.tap(find.text('Skip'));
      await tester.pumpAndSettle();

      expect(find.text('Welcome back'), findsOneWidget);
      expect(prefs.getBool(LocalKeys.isOpen), isTrue);
    });

    testWidgets('onboarding seen but no token: straight to login', (
      tester,
    ) async {
      await setUpApp({LocalKeys.isOpen: true});
      await pumpApp(tester);

      expect(find.text('Welcome back'), findsOneWidget);
    });

    testWidgets('logged in: add to cart, see it in the cart, log out', (
      tester,
    ) async {
      await setUpApp({LocalKeys.isOpen: true, LocalKeys.accessToken: 'tok'});
      api.on('GET', 'products', 200, _products);
      api.on('GET', 'cart', 200, {'cartId': 'c1', 'cartItems': []});
      api.on('POST', 'cart/items', 200, {'message': 'Added', 'id': 'i1'});
      await pumpApp(tester);

      expect(find.text('Ruby Charm'), findsOneWidget);
      expect(find.text('Canvas Bag'), findsOneWidget);

      api.on('GET', 'cart', 200, _cartWith());
      await tester.tap(find.byTooltip('Add to cart').first);
      await tester.pumpAndSettle();

      expect(find.text('Ruby Charm added to cart'), findsOneWidget);
      expect(find.text('1'), findsOneWidget); // cart badge

      await tester.tap(find.text('Cart'));
      await tester.pumpAndSettle();
      expect(find.text('My Cart'), findsOneWidget);
      expect(find.text('Total: \$2100.00'), findsOneWidget);

      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Logout'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextButton, 'Logout'));
      await tester.pumpAndSettle();

      expect(find.text('Welcome back'), findsOneWidget);
      expect(prefs.getString(LocalKeys.accessToken), isNull);
    });
  });
}
