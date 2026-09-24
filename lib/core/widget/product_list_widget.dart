import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ict_hub_project/app/routes.dart';
import 'package:ict_hub_project/core/widget/product_tile_widget.dart';
import 'package:ict_hub_project/domain/models/products_model.dart';
import 'package:ict_hub_project/presentation/cubit/cart/cart_cubit.dart';

/// Product tiles that open the details screen or add to the cart.
class ProductListWidget extends StatelessWidget {
  const ProductListWidget({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text('No products found'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductTileWidget(
          product: product,
          onTap: () => context.pushNamed(
            Routes.productDetailsScreen,
            queryParameters: {'id': product.id ?? ''},
          ),
          onAddToCart: () =>
              context.read<CartCubit>().addItem(product: product),
        );
      },
    );
  }
}
