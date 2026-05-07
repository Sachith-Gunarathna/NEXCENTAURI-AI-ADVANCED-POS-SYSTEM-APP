import 'package:flutter/material.dart';
import '../theme/colors.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final double growth;

  const BalanceCard({super.key, required this.balance, required this.growth});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Balance',
          style: TextStyle(
            color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              '\$${balance.toStringAsFixed(2).replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]},")}',
              style: TextStyle(
                color: isDarkMode ? AppColors.darkText : AppColors.textDark,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              '+\$${growth.toStringAsFixed(2)}',
              style: const TextStyle(
                color: AppColors.successGreen,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.successGreen.withAlpha(25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Text(
                    '+46%',
                    style: TextStyle(
                      color: AppColors.successGreen,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.arrow_outward, size: 12, color: AppColors.successGreen),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
