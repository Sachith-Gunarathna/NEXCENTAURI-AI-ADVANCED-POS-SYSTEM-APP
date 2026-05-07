import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/colors.dart';
import 'dashboard_screen.dart';
import 'notifications_screen.dart';
import '../analytics/analytics_screen.dart';
import '../inventory/inventory_screen.dart';
import '../staff/staff_screen.dart';

import '../settings/profile_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    AnalyticsScreen(),
    InventoryScreen(),
    StaffScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildDrawerItem(int index, IconData icon, String title) {
    final isSelected = _selectedIndex == index;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        selected: isSelected,
        selectedTileColor: AppColors.primaryPurple.withAlpha(25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(
          icon,
          color: isSelected ? AppColors.primaryPurple : (isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.primaryPurple : (isDarkMode ? AppColors.darkText : AppColors.textDark),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {
          if (index != -1) {
            _onItemTapped(index);
            Navigator.pop(context); // Close drawer
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final logoAsset = isDarkMode
        ? 'lib/resources/NEXCENTAURI_WHITE_LOGO.png'
        : 'lib/resources/NEXCENTAURI_LOGO.png';

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu_rounded, color: isDarkMode ? AppColors.darkText : AppColors.textDark),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: Text(
            _selectedIndex == 0 ? 'Dashboard' : 
            _selectedIndex == 1 ? 'Analytics' : 
            _selectedIndex == 2 ? 'Inventory' : 'Staff',
            style: TextStyle(color: isDarkMode ? AppColors.darkText : AppColors.textDark, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_none_rounded, color: isDarkMode ? AppColors.darkText : AppColors.textDark),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                );
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Theme.of(context).cardColor,
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: isDarkMode ? AppColors.darkBackground : AppColors.background,
                ),
                child: Center(
                  child: Image.asset(
                    logoAsset,
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildDrawerItem(0, Icons.dashboard_rounded, 'Dashboard'),
              _buildDrawerItem(1, Icons.bar_chart_rounded, 'Analytics'),
              _buildDrawerItem(2, Icons.inventory_2_rounded, 'Inventory'),
              _buildDrawerItem(3, Icons.people_alt_rounded, 'Staff Management'),
              const Divider(indent: 20, endIndent: 20),
              _buildDrawerItem(-1, Icons.settings_rounded, 'Settings'),
              _buildDrawerItem(-1, Icons.help_outline_rounded, 'Support'),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context); // Close drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: AppColors.primaryPurple,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Admin User', style: TextStyle(fontWeight: FontWeight.bold, color: isDarkMode ? AppColors.darkText : AppColors.textDark)),
                            Text('admin@nexcentauri.ai', style: TextStyle(fontSize: 12, color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey)),
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.chevron_right_rounded, color: AppColors.textGrey, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: isDarkMode ? Colors.black.withAlpha(76) : Colors.black.withAlpha(20),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: AppColors.primaryPurple,
            unselectedItemColor: isDarkMode ? AppColors.darkTextGrey.withAlpha(127) : AppColors.textGrey.withAlpha(127),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Icon(Icons.dashboard_rounded, size: 26),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Icon(Icons.dashboard_rounded, size: 28),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Icon(Icons.bar_chart_rounded, size: 26),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Icon(Icons.bar_chart_rounded, size: 28),
                ),
                label: 'Analytics',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Icon(Icons.inventory_2_rounded, size: 26),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Icon(Icons.inventory_2_rounded, size: 28),
                ),
                label: 'Inventory',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Icon(Icons.people_alt_rounded, size: 26),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Icon(Icons.people_alt_rounded, size: 28),
                ),
                label: 'Staff',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
