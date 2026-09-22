import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ict_hub_project/app/app_router.dart';
import 'package:ict_hub_project/config/injection_container.dart';
import 'package:ict_hub_project/core/cubit/theme/theme_cubit.dart';
import 'package:ict_hub_project/core/cubit/theme/theme_state.dart';
import 'package:ict_hub_project/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'ICT Hub E-Commerce',
            debugShowCheckedModeBanner: false,
            theme: state.isDark
                ? AppTheme().darkTheme()
                : AppTheme().lightTheme(),
            routerConfig: AppRouter.appRouter,
          );
        },
      ),
    );
  }
}
