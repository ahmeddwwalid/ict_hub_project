import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ict_hub_project/app/routes.dart';
import 'package:ict_hub_project/core/constant/local_keys.dart';
import 'package:ict_hub_project/core/local_storage/base_local_storage.dart';

/// Decides where the app starts:
/// first launch -> onboarding, no saved token -> login, else products.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this._localStorage});

  final BaseLocalStorage _localStorage;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  Future<void> navigate() async {
    final bool? isOpen = await widget._localStorage.getBool(LocalKeys.isOpen);
    final String? token = await widget._localStorage.getString(
      LocalKeys.accessToken,
    );

    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    if (isOpen != true) {
      context.goNamed(Routes.onBoarding);
    } else if (token == null || token.isEmpty) {
      context.goNamed(Routes.loginScreen);
    } else {
      context.goNamed(Routes.productScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shopping_bag_rounded,
              size: 96,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'ICT Hub Store',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
