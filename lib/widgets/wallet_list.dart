import 'package:flutter/material.dart';
import '../theme/colors.dart';

class WalletList extends StatelessWidget {
  const WalletList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Wallet List',
              style: TextStyle(
                color: AppColors.textGrey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_box_rounded, color: AppColors.primaryGreen),
              onPressed: () {},
            ),
          ],
        ),
        Row(
          children: [
            Expanded(child: _buildWalletCard('Gopay', '\$100,327.18', '38% of balance', Colors.blue)),
            const SizedBox(width: 16),
            Expanded(child: _buildWalletCard('Paypal', '\$147,327.18', '42% of balance', Colors.indigo)),
          ],
        ),
      ],
    );
  }

  Widget _buildWalletCard(String name, String balance, String subtitle, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
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
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Icon(Icons.account_balance_wallet, color: iconColor, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Text(balance, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: AppColors.textGrey, fontSize: 10)),
        ],
      ),
    );
  }
}
