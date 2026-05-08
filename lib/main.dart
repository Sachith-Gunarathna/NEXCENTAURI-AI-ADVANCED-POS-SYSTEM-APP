import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'theme/colors.dart';
import 'screens/auth/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NexcentauriApp());
}

class NexcentauriApp extends StatelessWidget {
  const NexcentauriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexcentauri POS',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, // Automatically switch based on system settings
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primaryPurple,
        scaffoldBackgroundColor: AppColors.background,
        cardColor: AppColors.surface,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primaryPurple,
          secondary: AppColors.primaryPurple,
          surface: AppColors.surface,
          onSurface: AppColors.textDark,
          brightness: Brightness.light,
        ),
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.textDark),
          titleTextStyle: TextStyle(color: AppColors.textDark, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.textDark,
          contentTextStyle: const TextStyle(color: Colors.white, fontFamily: 'Inter'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 8,
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          titleTextStyle: const TextStyle(color: AppColors.textDark, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
          contentTextStyle: const TextStyle(color: AppColors.textGrey, fontSize: 14, fontFamily: 'Inter'),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.primaryPurple,
        scaffoldBackgroundColor: AppColors.darkBackground,
        cardColor: AppColors.darkSurface,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryPurple,
          secondary: AppColors.primaryPurple,
          surface: AppColors.darkSurface,
          onSurface: AppColors.darkText,
        ),
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.darkText),
          titleTextStyle: TextStyle(color: AppColors.darkText, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.primaryPurple,
          contentTextStyle: const TextStyle(color: Colors.white, fontFamily: 'Inter'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 8,
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: AppColors.darkSurface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          titleTextStyle: const TextStyle(color: AppColors.darkText, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
          contentTextStyle: const TextStyle(color: AppColors.darkTextGrey, fontSize: 14, fontFamily: 'Inter'),
        ),
      ),
      builder: (context, child) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
            statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
          ),
          child: child!,
        );
      },
      home: const SplashScreen(),
    );
  }
}
