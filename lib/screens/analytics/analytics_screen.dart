import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/analytics_kpi_card.dart';
import '../../utils/ui_utils.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String _selectedCategory = 'Sales';
  String _selectedPeriod = 'This Month';

  final List<String> _categories = [
    'Sales', 'Financial', 'Inventory', 'Customers', 'Staff', 'Suppliers', 'Audit'
  ];

  final List<String> _periods = [
    'Today', 'Yesterday', '7 Days', 'This Month', '30 Days', 'Last Month'
  ];

  void _showExportOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textGrey.withAlpha(50),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Export Report',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _buildExportTile(Icons.picture_as_pdf_rounded, 'Download PDF', AppColors.errorRed),
            _buildExportTile(Icons.table_chart_rounded, 'Export CSV', AppColors.successGreen),
            _buildExportTile(Icons.print_rounded, 'Print Report', AppColors.primaryPurple),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildExportTile(IconData icon, String title, Color color) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withAlpha(25),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textGrey),
      onTap: () {
        Navigator.pop(context);
        UIUtils.showPremiumSnackBar(context, '$title generated successfully');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Reports & Analytics'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => UIUtils.showPremiumSnackBar(context, 'Data refreshed'),
          ),
          IconButton(
            icon: const Icon(Icons.ios_share_rounded),
            onPressed: _showExportOptions,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Category Selector
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      onSelected: (val) => setState(() => _selectedCategory = cat),
                      backgroundColor: isDarkMode ? AppColors.darkSurface : Colors.white,
                      selectedColor: AppColors.primaryPurple,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : (isDarkMode ? AppColors.darkText : AppColors.textDark),
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 13,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      showCheckmark: false,
                      elevation: isSelected ? 4 : 0,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Period Selector
            SizedBox(
              height: 34,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _periods.length,
                itemBuilder: (context, index) {
                  final period = _periods[index];
                  final isSelected = _selectedPeriod == period;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () => setState(() => _selectedPeriod = period),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryPurple.withAlpha(40) : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? AppColors.primaryPurple : (isDarkMode ? Colors.white.withAlpha(30) : Colors.black.withAlpha(30)),
                          ),
                        ),
                        child: Text(
                          period,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? AppColors.primaryPurple : (isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            // KPI Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.4,
                children: const [
                  AnalyticsKpiCard(
                    title: 'Total Revenue',
                    subtitle: 'මුළු ආදායම',
                    value: 'Rs. 11595.00',
                    icon: Icons.payments_outlined,
                    iconColor: AppColors.primaryPurple,
                  ),
                  AnalyticsKpiCard(
                    title: 'Total Bills',
                    subtitle: 'මුළු බිල්පත්',
                    value: '6',
                    icon: Icons.receipt_outlined,
                    iconColor: AppColors.successGreen,
                  ),
                  AnalyticsKpiCard(
                    title: 'Avg Basket',
                    subtitle: 'සාමාන්‍ය අගය',
                    value: 'Rs. 1932.50',
                    icon: Icons.shopping_basket_outlined,
                    iconColor: AppColors.accentOrange,
                  ),
                  AnalyticsKpiCard(
                    title: 'Credit Sales',
                    subtitle: 'ණය විකුණුම්',
                    value: 'Rs. 0.00',
                    icon: Icons.credit_card_outlined,
                    iconColor: Colors.blue,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Chart Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
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
                    "REVENUE & PROFIT TREND",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 250,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval: 2000,
                          getDrawingHorizontalLine: (value) => FlLine(
                            color: isDarkMode ? Colors.white.withAlpha(15) : Colors.black.withAlpha(15),
                            strokeWidth: 1,
                          ),
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              interval: 5,
                              getTitlesWidget: (value, meta) => SideTitleWidget(
                                meta: meta,
                                space: 12,
                                child: Text(
                                  'May ${value.toInt() + 1}',
                                  style: TextStyle(
                                    color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 2000,
                              getTitlesWidget: (value, meta) => Text(
                                '${(value / 1000).toInt()}k',
                                style: TextStyle(
                                  color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              reservedSize: 28,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: const [
                              FlSpot(0, 3000), FlSpot(5, 3500), FlSpot(10, 3200),
                              FlSpot(15, 4800), FlSpot(20, 4200), FlSpot(25, 7500), FlSpot(30, 6800),
                            ],
                            isCurved: true,
                            color: AppColors.primaryPurple,
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryPurple.withAlpha(50),
                                  AppColors.primaryPurple.withAlpha(0),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                          LineChartBarData(
                            spots: const [
                              FlSpot(0, 1000), FlSpot(5, 1200), FlSpot(10, 1100),
                              FlSpot(15, 1800), FlSpot(20, 1600), FlSpot(25, 2500), FlSpot(30, 2200),
                            ],
                            isCurved: true,
                            color: AppColors.successGreen,
                            barWidth: 2,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(show: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
