import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ict_hub_project/config/injection_container.dart';
import 'package:ict_hub_project/features/products/presentation/cubit/product_cubit.dart';
import 'package:ict_hub_project/widgets/product_list.dart';

/// Categories tab: chips built from the fetched products; selecting one
/// asks the [ProductCubit] for that category's products.
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductCubit>()..fetchProducts(),
      child: const _CategoriesView(),
    );
  }
}

class _CategoriesView extends StatelessWidget {
  const _CategoriesView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<ProductCubit>();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          final selected = state.maybeMap(
            success: (s) => s.category,
            orElse: () => null,
          );
          final categories = cubit.categories;

          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: categories.map((category) {
                    final isSelected = category == selected;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (_) => cubit.fetchByCategory(category),
                        selectedColor: Colors.blueAccent,
                        labelStyle: theme.textTheme.bodyMedium?.copyWith(
                          color: isSelected ? Colors.white : null,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: state.map(
                  initial: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  loading: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  success: (s) => s.category == null
                      ? Center(
                          child: Text('Select a category',
                              style: theme.textTheme.bodyMedium),
                        )
                      : ProductList(products: s.products),
                  error: (e) => Center(child: Text(e.message)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
