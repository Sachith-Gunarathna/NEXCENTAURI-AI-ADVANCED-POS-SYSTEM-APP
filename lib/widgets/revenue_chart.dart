import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class RevenueProfitChart extends StatelessWidget {
  const RevenueProfitChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
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
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Revenue Analysis",
                    style: TextStyle(
                      fontWeight: FontWeight.w800, 
                      fontSize: 16,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    "Monthly performance overview",
                    style: TextStyle(fontSize: 11, color: AppColors.textGrey),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withAlpha(15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Last 30 Days",
                  style: TextStyle(
                    fontSize: 10, 
                    color: AppColors.primaryPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 2000,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.withAlpha(15),
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
                      interval: 6,
                      getTitlesWidget: (value, meta) {
                        if (value % 6 != 0) return Container();
                        return SideTitleWidget(
                          meta: meta,
                          space: 12,
                          child: Text(
                            'Day ${value.toInt()}', 
                            style: const TextStyle(color: AppColors.textGrey, fontSize: 9, fontWeight: FontWeight.bold)
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 2000,
                      getTitlesWidget: (value, meta) => Text(
                        '${(value / 1000).toInt()}k',
                        style: const TextStyle(color: AppColors.textGrey, fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                      reservedSize: 28,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 30,
                minY: 0,
                maxY: 6000,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 1000), FlSpot(5, 1500), FlSpot(10, 1200),
                      FlSpot(15, 2800), FlSpot(20, 2200), FlSpot(25, 4500), FlSpot(30, 3800),
                    ],
                    isCurved: true,
                    curveSmoothness: 0.4,
                    gradient: const LinearGradient(colors: AppColors.purpleGradient),
                    barWidth: 4,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
