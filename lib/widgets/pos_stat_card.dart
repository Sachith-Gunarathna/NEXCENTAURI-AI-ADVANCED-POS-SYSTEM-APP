import 'package:flutter/material.dart';
import '../theme/colors.dart';

class PosStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final List<Color> gradient;
  final String trend;

  const PosStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.gradient,
    required this.trend,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: isDarkMode ? Colors.white.withAlpha(15) : Colors.black.withAlpha(10),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black.withAlpha(76) : gradient.last.withAlpha(20),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradient),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.successGreen.withAlpha(20),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  trend,
                  style: const TextStyle(
                    color: AppColors.successGreen,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: isDarkMode ? AppColors.darkText : AppColors.textDark,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
