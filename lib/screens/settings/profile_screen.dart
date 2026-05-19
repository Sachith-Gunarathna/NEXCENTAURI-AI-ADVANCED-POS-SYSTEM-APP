import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../utils/ui_utils.dart';
import '../auth/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Admin User';
  String userEmail = 'admin@nexcentauri.com';

  void _showEditProfileDialog() {
    final TextEditingController nameController = TextEditingController(text: userName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: Text('Edit Profile', style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkText : AppColors.textDark)),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Display Name'),
          style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkText : AppColors.textDark),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() => userName = nameController.text);
              Navigator.pop(context);
              UIUtils.showPremiumSnackBar(context, 'Profile updated successfully');
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryPurple),
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    UIUtils.showPremiumConfirmDialog(
      context: context,
      title: 'Confirm Logout',
      message: 'Are you sure you want to log out of Nexcentauri POS?',
      confirmText: 'Log Out',
      isDanger: true,
      onConfirm: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          (route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Admin Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Header
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primaryPurple, width: 3),
                    ),
                    child: const CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage('https://i.ibb.co/rRbc0px8/Whats-App-Image-2026-05-05-at-1-01-24-PM.jpg'),
                    ),
                  ),
                  InkWell(
                    onTap: _showEditProfileDialog,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryPurple,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              userName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? AppColors.darkText : AppColors.textDark,
              ),
            ),
            Text(
              userEmail,
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryPurple.withAlpha(30),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Senior Administrator',
                style: TextStyle(
                  color: AppColors.primaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Stats Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  _buildStatItem(context, 'Total Sales', '1.2k', 'Sales details coming soon'),
                  _buildStatItem(context, 'Avg Rating', '4.9', 'Rating breakdown coming soon'),
                  _buildStatItem(context, 'Shifts', '156', 'Shift history coming soon'),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Settings List
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode ? Colors.black.withAlpha(50) : Colors.black.withAlpha(10),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSettingTile(context, Icons.person_outline_rounded, 'Personal Info', 'Personal settings coming soon'),
                  _buildSettingTile(context, Icons.security_rounded, 'Security & Privacy', 'Security settings coming soon'),
                  _buildSettingTile(context, Icons.notifications_none_rounded, 'Notifications', 'Notification settings coming soon'),
                  _buildSettingTile(context, Icons.palette_outlined, 'Display Settings', 'Theme settings coming soon'),
                  _buildSettingTile(context, Icons.help_outline_rounded, 'Help & Support', 'Help section coming soon', isLast: true),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: _showLogoutDialog,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.errorRed, width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: AppColors.errorRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, String snackbarMsg) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: InkWell(
        onTap: () => UIUtils.showPremiumSnackBar(context, snackbarMsg),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? AppColors.darkText : AppColors.textDark,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile(BuildContext context, IconData icon, String title, String snackbarMsg, {bool isLast = false}) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: AppColors.primaryPurple),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isDarkMode ? AppColors.darkText : AppColors.textDark,
            ),
          ),
          trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textGrey),
          onTap: () => UIUtils.showPremiumSnackBar(context, snackbarMsg),
        ),
        if (!isLast)
          Divider(
            height: 1,
            indent: 56,
            endIndent: 16,
            color: isDarkMode ? Colors.white.withAlpha(15) : Colors.black.withAlpha(15),
          ),
      ],
    );
  }
}
