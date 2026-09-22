import 'package:flutter/material.dart';
import '../utils/theme_colors.dart';
import '../models/product.dart';
import 'product_details_screen.dart';

/// Categories screen showing products grouped by category.
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late String _selectedCategory;
  late List<String> _categories;

  static const _backgroundColor = Color(0xFF121212);
  static const _cardColor = Color(0xFF1E1E1E);
  static const _chipColor = Color(0xFF2A2A2A);

  @override
  void initState() {
    super.initState();
    _categories = mockProducts
        .map((p) => p.category)
        .toSet()
        .toList();
    _selectedCategory = _categories.first;
  }

  List<Product> _getProductsByCategory(String category) {
    return mockProducts.where((p) => p.category == category).toList();
  }

  void _handleTap(BuildContext context, Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProductDetailsScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedProducts = _getProductsByCategory(_selectedCategory);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          // Category chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: _categories.map((category) {
                final isSelected = category == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    backgroundColor: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF2A2A2A)
                        : Colors.grey[200],
                    selectedColor: Colors.blueAccent,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Products list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: selectedProducts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final product = selectedProducts[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => _handleTap(context, product),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF1E1E1E)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.image,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox(
                              width: 56,
                              height: 56,
                              child: Icon(
                                Icons.image_not_supported,
                                color: ThemeColors.getIconColor(context),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: ThemeColors.getTextColor(context),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                product.category,
                                style: TextStyle(
                                  color: ThemeColors.getTertiaryTextColor(context),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: ThemeColors.getTextColor(context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

