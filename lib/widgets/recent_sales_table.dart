import 'package:flutter/material.dart';
import '../theme/colors.dart';

class RecentSalesTable extends StatelessWidget {
  final VoidCallback? onViewAll;
  const RecentSalesTable({super.key, this.onViewAll});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      width: double.infinity,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Sales", 
                style: TextStyle(
                  fontWeight: FontWeight.w800, 
                  fontSize: 16,
                  color: isDarkMode ? AppColors.darkText : AppColors.textDark,
                )
              ),
              TextButton(
                onPressed: onViewAll,
                child: const Text(
                  "View All", 
                  style: TextStyle(
                    fontSize: 12, 
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryPurple,
                  )
                )
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildSaleRow(context, "INV-0003", "Walk-in Customer", "CASH", "Rs. 4,630.00", "Paid"),
          _buildSaleRow(context, "INV-0002", "John Doe", "CARD", "Rs. 1,200.00", "Paid"),
          _buildSaleRow(context, "INV-0001", "Walk-in Customer", "CASH", "Rs. 350.00", "Pending"),
        ],
      ),
    );
  }

  Widget _buildSaleRow(BuildContext context, String id, String customer, String method, String amount, String status) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final statusColor = status == "Paid" ? AppColors.successGreen : AppColors.accentOrange;
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkBackground.withAlpha(127) : AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.receipt_long_rounded, color: AppColors.primaryPurple, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  id, 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 14,
                    color: isDarkMode ? AppColors.darkText : AppColors.textDark,
                  )
                ),
                Text(
                  customer, 
                  style: TextStyle(
                    color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey, 
                    fontSize: 11
                  )
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount, 
                style: TextStyle(
                  fontWeight: FontWeight.w900, 
                  fontSize: 14, 
                  color: isDarkMode ? AppColors.darkText : AppColors.textDark,
                )
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    status, 
                    style: TextStyle(
                      fontSize: 10, 
                      fontWeight: FontWeight.bold, 
                      color: statusColor,
                    )
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
