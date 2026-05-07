import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../main/main_shell.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 32, 
                  fontWeight: FontWeight.bold, 
                  color: isDarkMode ? AppColors.darkText : AppColors.textDark
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Set up your Nexcentauri POS dashboard.',
                style: TextStyle(
                  fontSize: 16, 
                  color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey
                ),
              ),
              const SizedBox(height: 40),
              _buildTextField(context, label: 'Full Name', icon: Icons.person_outline),
              const SizedBox(height: 20),
              _buildTextField(context, label: 'Shop Name', icon: Icons.storefront_outlined),
              const SizedBox(height: 20),
              _buildTextField(context, label: 'Email Address', icon: Icons.email_outlined),
              const SizedBox(height: 20),
              _buildTextField(context, label: 'Password', icon: Icons.lock_outline, isPassword: true),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? AppColors.primaryPurple : AppColors.textDark,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const MainShell()),
                  ),
                  child: const Text('Sign Up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ', 
                    style: TextStyle(color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey)
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SignInScreen())),
                    child: Text(
                      'Log In', 
                      style: TextStyle(
                        color: isDarkMode ? AppColors.primaryPurple : AppColors.textDark, 
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, {required String label, required IconData icon, bool isPassword = false}) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return TextField(
      obscureText: isPassword,
      style: TextStyle(color: isDarkMode ? AppColors.darkText : AppColors.textDark),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey),
        prefixIcon: Icon(icon, color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey),
        suffixIcon: isPassword ? Icon(Icons.visibility_off, color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey) : null,
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
    );
  }
}
