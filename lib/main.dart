import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ict_hub_project/app/app_router.dart';
import 'package:ict_hub_project/config/injection_container.dart';
import 'package:ict_hub_project/core/cubit/theme/theme_cubit.dart';
import 'package:ict_hub_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ict_hub_project/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router = createRouter(getIt<AuthCubit>());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<ThemeCubit>()),
        BlocProvider.value(value: getIt<AuthCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'ICT Hub E-Commerce',
            debugShowCheckedModeBanner: false,
            theme: AppTheme().lightTheme(),
            darkTheme: AppTheme().darkTheme(),
            themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
            routerConfig: _router,
          );
        },
      ),
    );
  }
}
