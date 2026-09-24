import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ict_hub_project/app/app_router.dart';
import 'package:ict_hub_project/core/cubit/theme/theme_cubit.dart';
import 'package:ict_hub_project/core/cubit/theme/theme_state.dart';
import 'package:ict_hub_project/core/utils/app_theme.dart';
import 'package:ict_hub_project/injection_container.dart';
import 'package:ict_hub_project/presentation/cubit/auth/auth_cubit.dart';
import 'package:ict_hub_project/presentation/cubit/cart/cart_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.router});

  /// Defaults to [AppRouter.appRouter]; tests pass a fresh one.
  final GoRouter? router;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        // App-wide: used by the auth screens and settings.
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        // App-wide: the cart tab, its badge and "Add to cart" share it.
        BlocProvider(create: (context) => getIt<CartCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'ICT Hub Store',
            debugShowCheckedModeBanner: false,
            theme: AppTheme().lightTheme(),
            darkTheme: AppTheme().darkTheme(),
            themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
            routerConfig: router ?? AppRouter.appRouter,
          );
        },
      ),
    );
  }
}
