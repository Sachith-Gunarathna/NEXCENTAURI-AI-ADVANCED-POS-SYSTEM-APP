import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class RevenueProfitChart extends StatelessWidget {
  const RevenueProfitChart({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Revenue Analysis",
                    style: TextStyle(
                      fontWeight: FontWeight.w800, 
                      fontSize: 16,
                      color: isDarkMode ? AppColors.darkText : AppColors.textDark,
                    ),
                  ),
                  Text(
                    "Monthly performance overview",
                    style: TextStyle(
                      fontSize: 11, 
                      color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withAlpha(25),
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
                    color: isDarkMode ? Colors.white.withAlpha(15) : Colors.black.withAlpha(15),
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
                            style: TextStyle(
                              color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey, 
                              fontSize: 9, 
                              fontWeight: FontWeight.bold
                            )
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
                        style: TextStyle(
                          color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey, 
                          fontSize: 9, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      reservedSize: 28,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => isDarkMode ? AppColors.darkSurface : AppColors.surface,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          'Rs. ${spot.y.toInt()}',
                          TextStyle(
                            color: isDarkMode ? AppColors.darkText : AppColors.textDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
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
                    color: AppColors.primaryPurple,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                        radius: 4,
                        color: AppColors.primaryPurple,
                        strokeWidth: 2,
                        strokeColor: isDarkMode ? AppColors.darkSurface : AppColors.surface,
                      ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryPurple.withAlpha(60),
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
