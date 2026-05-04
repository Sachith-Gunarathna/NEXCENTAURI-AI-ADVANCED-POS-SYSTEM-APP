import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'theme/colors.dart';
import 'screens/auth/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, // For Android
    statusBarBrightness: Brightness.light, // For iOS
  ));
  runApp(const NexcentauriApp());
}

class NexcentauriApp extends StatelessWidget {
  const NexcentauriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexcentauri POS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryGreen,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primaryGreen,
        ),
        fontFamily: 'Inter', // Defaulting to a clean sans-serif
      ),
      home: const SplashScreen(),
    );
  }
}
