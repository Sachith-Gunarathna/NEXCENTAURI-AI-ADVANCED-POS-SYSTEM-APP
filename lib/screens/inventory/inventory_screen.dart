import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _inventory = [
    {'name': 'Premium Coffee Beans', 'category': 'Beverages', 'price': 'Rs. 2,450.00', 'stock': 12, 'image': 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?q=80&w=200&auto=format&fit=crop'},
    {'name': 'Organic Green Tea', 'category': 'Beverages', 'price': 'Rs. 850.00', 'stock': 4, 'image': 'https://images.unsplash.com/photo-1523920290228-4f321a939b4c?q=80&w=200&auto=format&fit=crop'},
    {'name': 'Whole Wheat Bread', 'category': 'Bakery', 'price': 'Rs. 420.00', 'stock': 25, 'image': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=200&auto=format&fit=crop'},
    {'name': 'Unsalted Butter', 'category': 'Dairy', 'price': 'Rs. 1,100.00', 'stock': 0, 'image': 'https://images.unsplash.com/photo-1589985270826-4b7bb135bc9d?q=80&w=200&auto=format&fit=crop'},
    {'name': 'Dark Chocolate 70%', 'category': 'Snacks', 'price': 'Rs. 650.00', 'stock': 18, 'image': 'https://images.unsplash.com/photo-1549007994-cb92caedaabc?q=80&w=200&auto=format&fit=crop'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Stock Distribution Graph
          _buildStockGraph(context),
          // Search & Filters
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  style: TextStyle(color: isDarkMode ? AppColors.darkText : AppColors.textDark),
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    hintStyle: TextStyle(color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey),
                    prefixIcon: Icon(Icons.search_rounded, color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 36,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: ['All', 'Beverages', 'Bakery', 'Dairy', 'Snacks'].map((filter) {
                      final isSelected = _selectedFilter == filter;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: InkWell(
                          onTap: () => setState(() => _selectedFilter = filter),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primaryPurple : (isDarkMode ? AppColors.darkSurface : Colors.white),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: isSelected ? AppColors.primaryPurple : (isDarkMode ? Colors.white.withAlpha(20) : Colors.black.withAlpha(20))),
                            ),
                            child: Center(
                              child: Text(
                                filter,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? Colors.white : (isDarkMode ? AppColors.darkText : AppColors.textDark),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          // Stats Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildStockStat('Low Stock', '2 Items', AppColors.accentOrange, Icons.warning_amber_rounded),
                const SizedBox(width: 12),
                _buildStockStat('Out of Stock', '1 Item', AppColors.errorRed, Icons.error_outline_rounded),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Product List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _inventory.length,
            itemBuilder: (context, index) {
              final item = _inventory[index];
              if (_selectedFilter != 'All' && item['category'] != _selectedFilter) return const SizedBox.shrink();
              return _buildProductCard(item);
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildStockGraph(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      height: 220,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black.withAlpha(50) : Colors.black.withAlpha(5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "STOCK LEVELS BY CATEGORY",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 30,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(fontSize: 10, fontWeight: FontWeight.bold);
                        String text = '';
                        switch (value.toInt()) {
                          case 0: text = 'Bev'; break;
                          case 1: text = 'Bak'; break;
                          case 2: text = 'Dai'; break;
                          case 3: text = 'Sna'; break;
                        }
                        return SideTitleWidget(
                          meta: meta,
                          space: 8,
                          child: Text(text, style: style.copyWith(color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey)),
                        );
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _makeBarGroup(0, 16, AppColors.primaryPurple),
                  _makeBarGroup(1, 25, AppColors.successGreen),
                  _makeBarGroup(2, 8, AppColors.accentOrange),
                  _makeBarGroup(3, 18, Colors.blue),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _makeBarGroup(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 16,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 30,
            color: color.withAlpha(20),
          ),
        ),
      ],
    );
  }

  Widget _buildStockStat(String label, String value, Color color, IconData icon) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDarkMode ? AppColors.darkText : AppColors.textDark)),
                Text(label, style: TextStyle(fontSize: 10, color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> item) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final int stock = item['stock'];
    final Color statusColor = stock == 0 ? AppColors.errorRed : (stock < 5 ? AppColors.accentOrange : AppColors.successGreen);
    final String statusText = stock == 0 ? 'Out of Stock' : (stock < 5 ? 'Low Stock' : 'In Stock');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black.withAlpha(50) : Colors.black.withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item['image'], 
              width: 60, 
              height: 60, 
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 60,
                height: 60,
                color: isDarkMode ? AppColors.darkSurface : AppColors.background,
                child: const Icon(Icons.image_not_supported_rounded, color: AppColors.textGrey, size: 20),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: isDarkMode ? AppColors.darkText : AppColors.textDark)),
                const SizedBox(height: 2),
                Text(item['category'], style: TextStyle(fontSize: 12, color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 4),
                    Text('$statusText • $stock units', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: statusColor)),
                  ],
                ),
              ],
            ),
          ),
          Text(item['price'], style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: AppColors.primaryPurple)),
        ],
      ),
    );
  }
}
