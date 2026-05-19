import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../utils/ui_utils.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, dynamic>> transactions = [
      {'id': 'INV-0004', 'customer': 'Kamal Sunil', 'amount': 'Rs. 5,200.00', 'method': 'CASH', 'time': '10:45 AM', 'status': 'Paid'},
      {'id': 'INV-0003', 'customer': 'Walk-in Customer', 'amount': 'Rs. 4,630.00', 'method': 'CARD', 'time': '09:30 AM', 'status': 'Paid'},
      {'id': 'INV-0002', 'customer': 'John Doe', 'amount': 'Rs. 1,200.00', 'method': 'CASH', 'time': 'Yesterday', 'status': 'Paid'},
      {'id': 'INV-0001', 'customer': 'Walk-in Customer', 'amount': 'Rs. 350.00', 'method': 'CASH', 'time': 'Yesterday', 'status': 'Refunded'},
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Transaction History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () => UIUtils.showPremiumSnackBar(context, 'Filters coming soon'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final tx = transactions[index];
          final statusColor = tx['status'] == 'Paid' ? AppColors.successGreen : AppColors.errorRed;

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
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
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryPurple.withAlpha(20),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.receipt_long_rounded, color: AppColors.primaryPurple, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tx['id'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDarkMode ? AppColors.darkText : AppColors.textDark)),
                      Text(tx['customer'], style: TextStyle(fontSize: 12, color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(tx['method'], style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primaryPurple)),
                          const SizedBox(width: 8),
                          Text(tx['time'], style: TextStyle(fontSize: 10, color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey)),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(tx['amount'], style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: isDarkMode ? AppColors.darkText : AppColors.textDark)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        tx['status'],
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: statusColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
