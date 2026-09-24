import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ict_hub_project/core/widget/app_network_image.dart';
import 'package:ict_hub_project/domain/models/products_model.dart';
import 'package:ict_hub_project/presentation/cubit/cart/cart_cubit.dart';
import 'package:ict_hub_project/presentation/cubit/cart/cart_state.dart';
import 'package:ict_hub_project/presentation/cubit/product_details/product_details_cubit.dart';
import 'package:ict_hub_project/presentation/cubit/product_details/product_details_state.dart';
import 'package:ict_hub_project/core/widget/error_view_widget.dart';

/// Loads one product by [productId] from the API.
class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  void _onCartState(BuildContext context, CartState state) {
    if (!(ModalRoute.of(context)?.isCurrent ?? true)) return;

    final messenger = ScaffoldMessenger.of(context);
    switch (state) {
      case CartItemAddedState(:final productName):
        messenger.showSnackBar(
          SnackBar(content: Text('$productName added to cart')),
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
        appBar: AppBar(),
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            return switch (state) {
              ProductDetailsInitialState() || ProductDetailsLoadingState() =>
                const Center(child: CircularProgressIndicator()),
              ProductDetailsFailureState(:final message) => ErrorViewWidget(
                message: message,
                onRetry: () => context
                    .read<ProductDetailsCubit>()
                    .getProductDetails(productId: productId),
              ),
              ProductDetailsSuccessState(:final product) => _DetailsBody(
                product: product,
              ),
            };
          },
        ),
      ),
    );
  }
}

class _DetailsBody extends StatelessWidget {
  const _DetailsBody({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stock = product.stock ?? 0;
    final discount = product.discountPercentage ?? 0;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 280,
                  color: Colors.white,
                  padding: const EdgeInsets.all(24),
                  child: AppNetworkImage(
                    url: product.coverPictureUrl,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        children: [
                          for (final category in product.categories ?? [])
                            Chip(label: Text(category)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        product.name ?? '',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            '\$${(product.price ?? 0).toStringAsFixed(2)}',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (discount > 0) ...[
                            const SizedBox(width: 12),
                            Text(
                              '-${discount.toStringAsFixed(0)}%',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.error,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        stock > 0 ? '$stock in stock' : 'Out of stock',
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(height: 20),
                      Text('Description', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(
                        product.description ?? '',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SafeArea(
          minimum: const EdgeInsets.all(16),
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, cartState) {
              final isBusy = cartState is CartLoadingState;
              return FilledButton.icon(
                onPressed: stock <= 0 || isBusy
                    ? null
                    : () => context.read<CartCubit>().addItem(product: product),
                icon: const Icon(Icons.add_shopping_cart),
                label: Text(stock <= 0 ? 'Out of stock' : 'Add to cart'),
              );
            },
          ),
        ),
      ],
    );
  }
}
