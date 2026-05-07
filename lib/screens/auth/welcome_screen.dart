import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final logoSize = screenWidth * 0.6; // 60% of screen width
    final logoHeight = screenHeight * 0.1;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              // Logo
              Image.asset(
                isDarkMode
                    ? 'lib/resources/NEXCENTAURI_WHITE_LOGO.png'
                    : 'lib/resources/NEXCENTAURI_LOGO.png',
                width: logoSize,
                height: logoHeight,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 40),
              Text(
                'Nexcentauri AI POS',
                style: TextStyle(
                  fontSize: 32, 
                  fontWeight: FontWeight.bold, 
                  color: isDarkMode ? AppColors.darkText : AppColors.primaryPurple
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Manage your business anywhere,\nanytime with smart analytics.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16, 
                  color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey, 
                  height: 1.5
                ),
              ),
              const Spacer(),
              // Login Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? AppColors.primaryPurple : AppColors.textDark,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignInScreen())),
                  child: const Text('Log In', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 16),
              // Sign Up Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: isDarkMode ? AppColors.primaryPurple : AppColors.textDark, 
                      width: 2
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpScreen())),
                  child: Text(
                    'Create Account', 
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold, 
                      color: isDarkMode ? AppColors.primaryPurple : AppColors.textDark
                    )
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}