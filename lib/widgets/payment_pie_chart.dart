import 'package:flutter/material.dart';
import '../theme/colors.dart';

class PaymentPieChart extends StatelessWidget {
  const PaymentPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black.withAlpha(50) : Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Payments",
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 14,
              color: isDarkMode ? AppColors.darkText : AppColors.textDark,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              // Mock Pie Chart representation
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      value: 0.7,
                      strokeWidth: 12,
                      backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                      color: AppColors.primaryPurple,
                    ),
                  ),
                  Text(
                    "70%", 
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 12,
                      color: isDarkMode ? AppColors.darkText : AppColors.textDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  children: [
                    _buildLegendItem("Cash", "Rs. 7,680.00", AppColors.primaryPurple, isDarkMode),
                    _buildLegendItem("Card", "Rs. 0.00", AppColors.accentBlue, isDarkMode),
                    _buildLegendItem("Credit", "Rs. 0.00", AppColors.accentOrange, isDarkMode),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, String amount, Color color, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Text(
                label, 
                style: TextStyle(
                  fontSize: 12, 
                  color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey
                ),
              ),
            ],
          ),
          Text(
            amount, 
            style: TextStyle(
              fontSize: 12, 
              fontWeight: FontWeight.bold,
              color: isDarkMode ? AppColors.darkText : AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
