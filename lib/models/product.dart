/// Shared product model used across the Product and Product Details
/// screens. Replace [mockProducts] with a real API call later —
/// the screens that use this list won't need to change shape.
class Product {
  final String title;
  final double price;
  final String category;
  final String description;
  final String image;

  const Product({
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
  });
}

const List<Product> mockProducts = [
  Product(
    title: 'Wireless Headphones',
    price: 59.99,
    category: 'Electronics',
    description:
        'Over-ear wireless headphones with noise cancellation and '
        '20-hour battery life.',
    image: 'https://picsum.photos/seed/headphones/400',
  ),
  Product(
    title: 'Leather Backpack',
    price: 89.50,
    category: 'Bags',
    description:
        'Durable leather backpack with padded laptop compartment, '
        'fits up to a 15-inch laptop.',
    image: 'https://picsum.photos/seed/backpack/400',
  ),
  Product(
    title: 'Smart Watch',
    price: 129.00,
    category: 'Electronics',
    description:
        'Fitness tracking smart watch with heart-rate monitor and '
        '7-day battery life.',
    image: 'https://picsum.photos/seed/smartwatch/400',
  ),
  Product(
    title: 'Ceramic Mug Set',
    price: 24.99,
    category: 'Home',
    description: 'Set of 4 handcrafted ceramic mugs, dishwasher safe.',
    image: 'https://picsum.photos/seed/mug/400',
  ),
];
