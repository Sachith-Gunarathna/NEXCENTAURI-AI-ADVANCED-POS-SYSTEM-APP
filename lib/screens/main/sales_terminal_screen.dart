import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../utils/ui_utils.dart';

class SalesTerminalScreen extends StatefulWidget {
  const SalesTerminalScreen({super.key});

  @override
  State<SalesTerminalScreen> createState() => _SalesTerminalScreenState();
}

class _SalesTerminalScreenState extends State<SalesTerminalScreen> {
  final List<Map<String, dynamic>> _products = [
    {'name': 'Premium Coffee', 'price': 450.00, 'image': 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=200', 'cat': 'Drinks'},
    {'name': 'Green Tea', 'price': 320.00, 'image': 'https://images.unsplash.com/photo-1523920290228-4f321a939b4c?w=200', 'cat': 'Drinks'},
    {'name': 'Croissant', 'price': 280.00, 'image': 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=200', 'cat': 'Bakery'},
    {'name': 'Chocolate Cake', 'price': 550.00, 'image': 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=200', 'cat': 'Bakery'},
    {'name': 'Apple Juice', 'price': 380.00, 'image': 'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=200', 'cat': 'Drinks'},
    {'name': 'Bagel', 'price': 340.00, 'image': 'https://images.unsplash.com/photo-1585478259715-876acc5be8eb?w=200', 'cat': 'Bakery'},
  ];

  final List<Map<String, dynamic>> _cart = [];
  String _selectedCategory = 'All';

  double get _total => _cart.fold(0, (sum, item) => sum + (item['price'] * item['qty']));

  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      final index = _cart.indexWhere((item) => item['name'] == product['name']);
      if (index >= 0) {
        _cart[index]['qty']++;
      } else {
        _cart.add({...product, 'qty': 1});
      }
    });
    UIUtils.showPremiumSnackBar(context, '${product['name']} added to cart');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Sales Terminal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Category Tabs
          _buildCategoryBar(),
          // Product Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                if (_selectedCategory != 'All' && product['cat'] != _selectedCategory) return const SizedBox.shrink();
                return _buildProductCard(product);
              },
            ),
          ),
          // Checkout Summary
          _buildCheckoutBar(),
        ],
      ),
    );
  }

  Widget _buildCategoryBar() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: ['All', 'Drinks', 'Bakery', 'Meals'].map((cat) {
          final isSelected = _selectedCategory == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ChoiceChip(
              label: Text(cat),
              selected: isSelected,
              onSelected: (_) => setState(() => _selectedCategory = cat),
              selectedColor: AppColors.primaryPurple,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : (isDarkMode ? AppColors.darkText : AppColors.textDark),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () => _addToCart(product),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.black.withAlpha(50) : Colors.black.withAlpha(5),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: Image.network(
                  product['image'],
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.image_not_supported_rounded)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: isDarkMode ? AppColors.darkText : AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rs. ${product['price']}',
                    style: const TextStyle(
                      color: AppColors.primaryPurple,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutBar() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (_cart.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 20, offset: const Offset(0, -5)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_cart.length} Items Selected',
                  style: TextStyle(color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Total: Rs. $_total',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: isDarkMode ? AppColors.darkText : AppColors.textDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  setState(() => _cart.clear());
                  UIUtils.showPremiumSnackBar(context, 'Order processed successfully');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text(
                  'Complete Sale',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
