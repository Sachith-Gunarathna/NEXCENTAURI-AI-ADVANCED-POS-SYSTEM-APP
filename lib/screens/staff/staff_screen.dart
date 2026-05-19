import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  final List<Map<String, dynamic>> _staff = [
    {'name': 'Admin User', 'role': 'Senior Admin', 'status': 'Active', 'email': 'admin@nexcentauri.ai', 'rating': '4.9'},
    {'name': 'Kamal Perera', 'role': 'Cashier', 'status': 'On Break', 'email': 'kamal@nexcentauri.ai', 'rating': '4.7'},
    {'name': 'Sunil Silva', 'role': 'Manager', 'status': 'Active', 'email': 'sunil@nexcentauri.ai', 'rating': '4.8'},
    {'name': 'Nimal Siri', 'role': 'Cashier', 'status': 'Offline', 'email': 'nimal@nexcentauri.ai', 'rating': '4.5'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Summary Header
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: AppColors.purpleGradient),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem('Total Staff', '12'),
                Container(width: 1, height: 40, color: Colors.white.withAlpha(50)),
                _buildSummaryItem('On Duty', '8'),
                Container(width: 1, height: 40, color: Colors.white.withAlpha(50)),
                _buildSummaryItem('Avg Rating', '4.8'),
              ],
            ),
          ),
        ),
        // Staff List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _staff.length,
            itemBuilder: (context, index) {
              return _buildStaffCard(_staff[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.white.withAlpha(180), fontSize: 11)),
      ],
    );
  }

  Widget _buildStaffCard(Map<String, dynamic> person) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final statusColor = person['status'] == 'Active' ? AppColors.successGreen : (person['status'] == 'On Break' ? AppColors.accentOrange : AppColors.textGrey);

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
          CircleAvatar(
            radius: 25,
            backgroundColor: AppColors.primaryPurple.withAlpha(30),
            child: Text(person['name'][0], style: const TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(person['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDarkMode ? AppColors.darkText : AppColors.textDark)),
                Text(person['role'], style: TextStyle(fontSize: 12, color: AppColors.primaryPurple, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(width: 6, height: 6, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Text(person['status'], style: TextStyle(fontSize: 11, color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey)),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Icon(Icons.star_rounded, color: AppColors.accentOrange, size: 16),
                  Text(person['rating'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isDarkMode ? AppColors.darkText : AppColors.textDark)),
                ],
              ),
              const SizedBox(height: 8),
              Icon(Icons.chevron_right_rounded, color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey),
            ],
          ),
        ],
      ),
    );
  }
}
