import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:ict_hub_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ict_hub_project/features/products/domain/entity/product_entity.dart';
import 'package:ict_hub_project/screens/login_screen.dart';
import 'package:ict_hub_project/screens/otp_verification_screen.dart';
import 'package:ict_hub_project/screens/product_details_screen.dart';
import 'package:ict_hub_project/screens/product_screen.dart';
import 'package:ict_hub_project/screens/signup_screen.dart';

/// Re-runs the router's redirect whenever [stream] emits.
class _CubitRefresh extends ChangeNotifier {
  late final StreamSubscription<dynamic> _sub;

  _CubitRefresh(Stream<dynamic> stream) {
    _sub = stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

GoRouter createRouter(AuthCubit authCubit) => GoRouter(
      initialLocation: '/',
      refreshListenable: _CubitRefresh(authCubit.stream),
      routes: [
        GoRoute(path: '/', builder: (_, __) => const LoginScreen()),
        GoRoute(path: '/signup', builder: (_, __) => const SignUpScreen()),
        GoRoute(
          path: '/otp/:email',
          builder: (_, state) =>
              OtpVerificationScreen(email: state.pathParameters['email']!),
        ),
        GoRoute(path: '/products', builder: (_, __) => const ProductScreen()),
        GoRoute(
          path: '/product-details',
          builder: (_, state) =>
              ProductDetailsScreen(product: state.extra! as ProductEntity),
        ),
      ],
      redirect: (context, state) {
        final path = state.uri.path;
        final isAuthPage =
            path == '/' || path == '/signup' || path.startsWith('/otp/');
        final authed = authCubit.isAuthenticated;

        if (!authed && !isAuthPage) return '/';
        if (authed && isAuthPage) return '/products';
        return null;
      },
    );
