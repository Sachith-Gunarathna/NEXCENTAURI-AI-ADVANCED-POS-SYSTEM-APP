import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../utils/ui_utils.dart';

class WalletList extends StatelessWidget {
  const WalletList({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Wallet List',
              style: TextStyle(
                color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_box_rounded, color: AppColors.primaryPurple),
              onPressed: () => UIUtils.showPremiumSnackBar(context, 'Add wallet feature coming soon'),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(child: _buildWalletCard('Gopay', '\$100,327.18', '38% of balance', Colors.blue, isDarkMode, context)),
            const SizedBox(width: 16),
            Expanded(child: _buildWalletCard('Paypal', '\$147,327.18', '42% of balance', Colors.indigo, isDarkMode, context)),
          ],
        ),
      ],
    );
  }

  Widget _buildWalletCard(String name, String balance, String subtitle, Color iconColor, bool isDarkMode, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black.withAlpha(50) : Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
                name, 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? AppColors.darkText : AppColors.textDark
                )
              ),
              Icon(Icons.account_balance_wallet, color: iconColor, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            balance, 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 16,
              color: isDarkMode ? AppColors.darkText : AppColors.textDark
            )
          ),
          const SizedBox(height: 4),
          Text(
            subtitle, 
            style: TextStyle(
              color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey, 
              fontSize: 10
            )
          ),
        ],
      ),
    );
  }
}
