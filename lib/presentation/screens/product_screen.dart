import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ict_hub_project/core/widget/error_view_widget.dart';
import 'package:ict_hub_project/core/widget/product_list_widget.dart';
import 'package:ict_hub_project/presentation/cubit/products/product_cubit.dart';
import 'package:ict_hub_project/presentation/cubit/products/product_state.dart';

/// Products tab: every product from the API.
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return switch (state) {
            ProductInitialState() || ProductsLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            ProductsFailureState(:final message) => ErrorViewWidget(
              message: message,
              onRetry: () => context.read<ProductCubit>().fetchProducts(),
            ),
            ProductsSuccessState(:final products) => RefreshIndicator(
              onRefresh: () => context.read<ProductCubit>().fetchProducts(),
              child: ProductListWidget(products: products),
            ),
          };
        },
      ),
    );
  }
}
