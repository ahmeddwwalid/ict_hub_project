import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ict_hub_project/core/widget/app_network_image.dart';
import 'package:ict_hub_project/domain/models/cart_model.dart';
import 'package:ict_hub_project/presentation/cubit/cart/cart_cubit.dart';
import 'package:ict_hub_project/presentation/cubit/cart/cart_state.dart';
import 'package:ict_hub_project/core/widget/error_view_widget.dart';

/// Cart tab: the user's server-side cart with quantity controls and total.
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cart = state.cart;

          if (cart == null) {
            return switch (state) {
              CartFailureState(:final message) => ErrorViewWidget(
                message: message,
                onRetry: () => context.read<CartCubit>().getCart(),
              ),
              _ => const Center(child: CircularProgressIndicator()),
            };
          }

          return Column(
            children: [
              if (state is CartLoadingState) const LinearProgressIndicator(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => context.read<CartCubit>().getCart(),
                  child: cart.cartItems.isEmpty
                      ? const _EmptyCart()
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: cart.cartItems.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) => _CartItemTile(
                            item: cart.cartItems[index],
                            enabled: state is! CartLoadingState,
                          ),
                        ),
                ),
              ),
              if (cart.cartItems.isNotEmpty) _CartTotalBar(cart: cart),
            ],
          );
        },
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // A ListView so pull-to-refresh still works on an empty cart.
    return ListView(
      children: [
        const SizedBox(height: 120),
        Icon(
          Icons.shopping_cart_outlined,
          size: 96,
          color: theme.colorScheme.outline,
        ),
        const SizedBox(height: 16),
        Text(
          'Your cart is empty',
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Add products from the Products tab.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _CartItemTile extends StatelessWidget {
  const _CartItemTile({required this.item, required this.enabled});

  final CartItemModel item;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<CartCubit>();
    final stock = item.productStock;
    final canAdd = enabled && (stock == null || item.quantity < stock);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AppNetworkImage(
                url: item.productCoverUrl,
                width: 64,
                height: 64,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${(item.finalPricePerUnit ?? 0).toStringAsFixed(2)} each',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${(item.totalPrice ?? 0).toStringAsFixed(2)}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  tooltip: 'Remove',
                  onPressed: enabled
                      ? () => cubit.removeItem(itemId: item.itemId)
                      : null,
                  icon: const Icon(Icons.delete_outline),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: 'Decrease',
                      visualDensity: VisualDensity.compact,
                      onPressed: enabled
                          ? () => cubit.updateQuantity(
                              itemId: item.itemId,
                              quantity: item.quantity - 1,
                            )
                          : null,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text(
                      '${item.quantity}',
                      style: theme.textTheme.titleMedium,
                    ),
                    IconButton(
                      tooltip: 'Increase',
                      visualDensity: VisualDensity.compact,
                      onPressed: canAdd
                          ? () => cubit.updateQuantity(
                              itemId: item.itemId,
                              quantity: item.quantity + 1,
                            )
                          : null,
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CartTotalBar extends StatelessWidget {
  const _CartTotalBar({required this.cart});

  final CartResponse cart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      elevation: 8,
      color: theme.colorScheme.surfaceContainer,
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${cart.itemsCount} item${cart.itemsCount == 1 ? '' : 's'}',
              style: theme.textTheme.bodyMedium,
            ),
            Text(
              'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
