import 'package:flutter/material.dart';
import '../theme/colors.dart';

class RecentSalesTable extends StatelessWidget {
  const RecentSalesTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
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
              const Text("Recent Sales", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              TextButton(onPressed: () {}, child: const Text("View All", style: TextStyle(fontSize: 12))),
            ],
          ),
          const Divider(),
          _buildSaleRow("INV-0003", "Walk-in Customer", "CASH", "Rs. 4,630.00"),
          _buildSaleRow("INV-0002", "John Doe", "CARD", "Rs. 1,200.00"),
          _buildSaleRow("INV-0001", "Walk-in Customer", "CASH", "Rs. 350.00"),
        ],
      ),
    );
  }

  Widget _buildSaleRow(String id, String customer, String method, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(id, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text(customer, style: const TextStyle(color: AppColors.textGrey, fontSize: 11)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.primaryPurple)),
              Text(method, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textGrey)),
            ],
          ),
        ],
      ),
    );
  }
}
