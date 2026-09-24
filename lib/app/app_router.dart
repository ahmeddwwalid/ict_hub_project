import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ict_hub_project/app/routes.dart';
import 'package:ict_hub_project/core/constant/local_keys.dart';
import 'package:ict_hub_project/core/local_storage/base_local_storage.dart';
import 'package:ict_hub_project/injection_container.dart';
import 'package:ict_hub_project/presentation/cubit/product_details/product_details_cubit.dart';
import 'package:ict_hub_project/presentation/cubit/products/product_cubit.dart';
import 'package:ict_hub_project/presentation/layout/main_layout.dart';
import 'package:ict_hub_project/presentation/screens/cart_screen.dart';
import 'package:ict_hub_project/presentation/screens/categories_screen.dart';
import 'package:ict_hub_project/presentation/screens/login_screen.dart';
import 'package:ict_hub_project/presentation/screens/on_boarding_screen.dart';
import 'package:ict_hub_project/presentation/screens/otp_verification_screen.dart';
import 'package:ict_hub_project/presentation/screens/product_details_screen.dart';
import 'package:ict_hub_project/presentation/screens/product_screen.dart';
import 'package:ict_hub_project/presentation/screens/settings_screen.dart';
import 'package:ict_hub_project/presentation/screens/signup_screen.dart';

/// Lets code without a BuildContext (the Dio interceptor) navigate.
final navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter appRouter = createRouter();

  /// First launch -> onboarding; no saved token -> login; else products.
  static Future<String> _startLocation(BaseLocalStorage localStorage) async {
    final bool? isOpen = await localStorage.getBool(LocalKeys.isOpen);
    if (isOpen != true) return "/${Routes.onBoarding}";

    final String? token = await localStorage.getString(LocalKeys.accessToken);
    if (token == null || token.isEmpty) return "/${Routes.loginScreen}";

    return "/${Routes.productScreen}";
  }

  static GoRouter createRouter() => GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: "/",
    routes: [
      // No screen of its own: sends the user straight to where they belong.
      GoRoute(
        path: "/",
        redirect: (context, state) => _startLocation(getIt<BaseLocalStorage>()),
      ),
      GoRoute(
        path: "/${Routes.onBoarding}",
        name: Routes.onBoarding,
        builder: (context, state) {
          return OnboardingScreen(localStorage: getIt<BaseLocalStorage>());
        },
      ),
      GoRoute(
        path: "/${Routes.loginScreen}",
        name: Routes.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: "/${Routes.signUpScreen}",
        name: Routes.signUpScreen,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: "/${Routes.otpScreen}",
        name: Routes.otpScreen,
        builder: (context, state) {
          final String? email = state.uri.queryParameters['email'];
          return OtpVerificationScreen(email: email ?? "");
        },
      ),
      GoRoute(
        path: "/${Routes.productDetailsScreen}",
        name: Routes.productDetailsScreen,
        builder: (context, state) {
          final String id = state.uri.queryParameters['id'] ?? "";
          return BlocProvider(
            create: (context) =>
                getIt<ProductDetailsCubit>()..getProductDetails(productId: id),
            child: ProductDetailsScreen(productId: id),
          );
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayout(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/${Routes.productScreen}",
                name: Routes.productScreen,
                builder: (context, state) {
                  return BlocProvider(
                    create: (context) => getIt<ProductCubit>(),
                    child: const ProductScreen(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/${Routes.categoriesScreen}",
                name: Routes.categoriesScreen,
                builder: (context, state) {
                  // Its own ProductCubit, so a category filter doesn't
                  // leak into the Products tab.
                  return BlocProvider(
                    create: (context) => getIt<ProductCubit>(),
                    child: const CategoriesScreen(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/${Routes.cartScreen}",
                name: Routes.cartScreen,
                builder: (context, state) => const CartScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/${Routes.settingsScreen}",
                name: Routes.settingsScreen,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
