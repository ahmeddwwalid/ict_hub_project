import 'package:go_router/go_router.dart';
import 'package:ict_hub_project/screens/login_screen.dart';
import 'package:ict_hub_project/screens/product_screen.dart';

abstract class AppRouter {
  static final appRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/products',
        builder: (context, state) => const ProductScreen(),
      ),
    ],
    initialLocation: '/',
  );
}
