import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Inventory & Stock', 
          style: TextStyle(
            color: isDarkMode ? AppColors.darkText : AppColors.textDark, 
            fontWeight: FontWeight.bold
          )
        ),
      ),
      body: Center(
        child: Text(
          'Inventory Content Coming Soon', 
          style: TextStyle(color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey)
        ),
      ),
    );
  }
}
