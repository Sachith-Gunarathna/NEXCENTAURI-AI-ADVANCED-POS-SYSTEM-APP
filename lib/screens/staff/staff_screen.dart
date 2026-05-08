import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'HR & Staff', 
          style: TextStyle(
            color: isDarkMode ? AppColors.darkText : AppColors.textDark, 
            fontWeight: FontWeight.bold
          )
        ),
      ),
      body: Center(
        child: Text(
          'Staff Content Coming Soon', 
          style: TextStyle(color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey)
        ),
      ),
    );
  }
}
