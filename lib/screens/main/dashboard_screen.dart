import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/dashboard_header.dart';
import '../../widgets/pos_stat_card.dart';
import '../../widgets/payment_pie_chart.dart';
import '../../widgets/revenue_chart.dart';
import '../../widgets/recent_sales_table.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const DashboardHeader(userName: 'Admin'),
              const SizedBox(height: 24),
              // Main Stats Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: const [
                  PosStatCard(
                    title: "Total Revenue",
                    value: "Rs. 48,290",
                    icon: Icons.account_balance_wallet_rounded,
                    gradient: AppColors.purpleGradient,
                    trend: "+12.5%",
                  ),
                  PosStatCard(
                    title: "Net Profit",
                    value: "Rs. 12,400",
                    icon: Icons.analytics_rounded,
                    gradient: AppColors.greenGradient,
                    trend: "+8.2%",
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const RevenueProfitChart(),
              const SizedBox(height: 24),
              const PaymentPieChart(),
              const SizedBox(height: 24),
              const RecentSalesTable(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
