import 'package:flutter_test/flutter_test.dart';
import 'package:ict_hub_project/app/app_router.dart';
import 'package:ict_hub_project/app/routes.dart';
import 'package:ict_hub_project/core/constant/local_keys.dart';
import 'package:ict_hub_project/core/local_storage/base_local_storage.dart';
import 'package:ict_hub_project/domain/repos/product_repo.dart';
import 'package:ict_hub_project/injection_container.dart';
import 'package:ict_hub_project/main.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Runs the real app against the live API:
///   flutter test integration_test -d windows
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  /// Pumps frames until [finder] matches (network calls are real here).
  Future<void> pumpUntil(
    WidgetTester tester,
    Finder finder, {
    Duration timeout = const Duration(seconds: 30),
  }) async {
    final end = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(end)) {
      await tester.pump(const Duration(milliseconds: 200));
      if (finder.evaluate().isNotEmpty) return;
    }
    throw TestFailure('Timed out waiting for $finder');
  }

  testWidgets('onboarding, live products, and a rejected token', (
    tester,
  ) async {
    // Isolated storage so the test doesn't touch real app data.
    SharedPreferences.setMockInitialValues({});
    await initDependencies();
    final storage = getIt<BaseLocalStorage>();
    final router = AppRouter.createRouter();

    await tester.pumpWidget(MyApp(router: router));

    // First launch: onboarding -> login; isOpen gets saved.
    await pumpUntil(tester, find.text('Discover Accessories'));
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Get Started'));
    await pumpUntil(tester, find.text('Welcome back'));
    expect(await storage.getBool(LocalKeys.isOpen), isTrue);

    // The real product list parses through Dio -> repo -> model.
    final products = (await getIt<ProductRepo>().getProducts()).getOrElse(
      (failure) => throw TestFailure(failure.msg),
    );
    expect(products.items, isNotEmpty);
    final product = products.items.firstWhere((p) => (p.stock ?? 0) > 0);

    // The details screen loads that product from the live API.
    router.pushNamed(
      Routes.productDetailsScreen,
      queryParameters: {'id': product.id!},
    );
    await pumpUntil(tester, find.text(product.name!));
    expect(find.text('Add to cart'), findsOneWidget);

    // With a token the server rejects, "Add to cart" gets a 401: the
    // interceptor drops the token and sends the user back to login.
    await storage.setString(LocalKeys.accessToken, 'not-a-real-token');
    await tester.tap(find.text('Add to cart'));
    await pumpUntil(tester, find.text('Welcome back'));
    expect(await storage.getString(LocalKeys.accessToken), isNull);
    expect(await storage.getBool(LocalKeys.isOpen), isTrue);
  });
}
