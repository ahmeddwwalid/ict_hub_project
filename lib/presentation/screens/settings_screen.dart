import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ict_hub_project/app/routes.dart';
import 'package:ict_hub_project/core/cubit/theme/theme_cubit.dart';
import 'package:ict_hub_project/core/cubit/theme/theme_state.dart';
import 'package:ict_hub_project/presentation/cubit/auth/auth_cubit.dart';
import 'package:ict_hub_project/presentation/cubit/cart/cart_cubit.dart';

/// Settings tab: theme toggle and logout.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _handleLogout(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final cartCubit = context.read<CartCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              // Removes the saved token.
              await authCubit.logout();
              cartCubit.clear();
              if (context.mounted) context.goNamed(Routes.loginScreen);
            },
            child: Text(
              'Logout',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) => SwitchListTile(
                title: const Text('Dark mode'),
                subtitle: Text(
                  state.isDark ? 'Dark theme enabled' : 'Light theme enabled',
                ),
                secondary: Icon(
                  state.isDark ? Icons.dark_mode : Icons.light_mode,
                ),
                value: state.isDark,
                onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Account', style: theme.textTheme.labelLarge),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () => _handleLogout(context),
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              foregroundColor: theme.colorScheme.onError,
            ),
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
          const SizedBox(height: 24),
          Text('About', style: theme.textTheme.labelLarge),
          const SizedBox(height: 12),
          const Card(
            child: ListTile(
              title: Text('App Version'),
              trailing: Text('1.0.0'),
            ),
          ),
        ],
      ),
    );
  }
}
