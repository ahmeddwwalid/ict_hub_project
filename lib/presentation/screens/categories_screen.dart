import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ict_hub_project/presentation/cubit/products/product_cubit.dart';
import 'package:ict_hub_project/presentation/cubit/products/product_state.dart';
import 'package:ict_hub_project/core/widget/error_view_widget.dart';
import 'package:ict_hub_project/core/widget/product_list_widget.dart';

/// Categories tab: chips built from the products' categories; picking one
/// asks the API for that category's products.
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          final selected = switch (state) {
            ProductsSuccessState(:final category) => category,
            _ => null,
          };

          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    for (final category in cubit.categories)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: category == selected,
                          onSelected: (_) =>
                              cubit.fetchProducts(category: category),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: switch (state) {
                  ProductInitialState() || ProductsLoadingState() =>
                    const Center(child: CircularProgressIndicator()),
                  ProductsFailureState(:final message) => ErrorViewWidget(
                    message: message,
                    onRetry: () => cubit.fetchProducts(category: selected),
                  ),
                  ProductsSuccessState(:final products, :final category) =>
                    category == null
                        ? const Center(child: Text('Select a category'))
                        : ProductListWidget(products: products),
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
