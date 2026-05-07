import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: isDarkMode ? AppColors.darkText : AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? AppColors.darkText : AppColors.textDark,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Enter your email address and we will send you an OTP to reset your password.',
                style: TextStyle(
                  fontSize: 16, 
                  color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                style: TextStyle(color: isDarkMode ? AppColors.darkText : AppColors.textDark),
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  labelStyle: TextStyle(color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey),
                  prefixIcon: Icon(Icons.email_outlined, color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: isDarkMode ? AppColors.primaryPurple : AppColors.textDark, 
                      width: 2
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? AppColors.primaryPurple : AppColors.textDark,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    // TODO: Implement OTP Logic
                  },
                  child: const Text(
                    'Send OTP',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
