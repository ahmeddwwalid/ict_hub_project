import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ict_hub_project/presentation/cubit/cart/cart_cubit.dart';
import 'package:ict_hub_project/presentation/cubit/cart/cart_state.dart';

/// Bottom-tab shell: Products, Categories, Cart, Settings.
class MainLayout extends StatefulWidget {
  const MainLayout({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const int cartTabIndex = 2;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  void initState() {
    super.initState();
    // Fills the cart badge as soon as a logged-in user lands here.
    context.read<CartCubit>().getCart();
  }

  /// One place for cart feedback, whichever tab triggered it.
  void _onCartState(BuildContext context, CartState state) {
    // The details screen is pushed above this shell and reports its own.
    if (!(ModalRoute.of(context)?.isCurrent ?? true)) return;

    final messenger = ScaffoldMessenger.of(context);
    switch (state) {
      case CartItemAddedState(:final productName):
        messenger.showSnackBar(
          SnackBar(
            content: Text('$productName added to cart'),
            action: SnackBarAction(
              label: 'View',
              onPressed: () =>
                  widget.navigationShell.goBranch(MainLayout.cartTabIndex),
            ),
          ),
        );
      case CartFailureState(:final message):
        messenger.showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: _onCartState,
      child: Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final count = state.cart?.itemsCount ?? 0;
            return NavigationBar(
              selectedIndex: widget.navigationShell.currentIndex,
              onDestinationSelected: (index) => widget.navigationShell.goBranch(
                index,
                initialLocation: index == widget.navigationShell.currentIndex,
              ),
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.shopping_bag_outlined),
                  selectedIcon: Icon(Icons.shopping_bag),
                  label: 'Products',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.category_outlined),
                  selectedIcon: Icon(Icons.category),
                  label: 'Categories',
                ),
                NavigationDestination(
                  icon: Badge(
                    isLabelVisible: count > 0,
                    label: Text('$count'),
                    child: const Icon(Icons.shopping_cart_outlined),
                  ),
                  selectedIcon: Badge(
                    isLabelVisible: count > 0,
                    label: Text('$count'),
                    child: const Icon(Icons.shopping_cart),
                  ),
                  label: 'Cart',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
