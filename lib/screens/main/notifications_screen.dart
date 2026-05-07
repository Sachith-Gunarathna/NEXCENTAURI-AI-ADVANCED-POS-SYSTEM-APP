import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'New Sale Received',
      'message': 'Invoice INV-0004 for Rs. 5,200.00 has been paid.',
      'time': '2 mins ago',
      'type': 'sale',
      'isRead': false,
    },
    {
      'title': 'Low Stock Alert',
      'message': 'Item "Premium Coffee Beans" is below the threshold (5 units left).',
      'time': '1 hour ago',
      'type': 'inventory',
      'isRead': false,
    },
    {
      'title': 'System Update',
      'message': 'Nexcentauri POS v1.2.0 is now available with new analytics features.',
      'time': '3 hours ago',
      'type': 'system',
      'isRead': true,
    },
    {
      'title': 'Daily Summary',
      'message': 'Your total revenue for yesterday was Rs. 48,290.00.',
      'time': '1 day ago',
      'type': 'sale',
      'isRead': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (var n in _notifications) {
                  n['isRead'] = true;
                }
              });
            },
            child: const Text('Mark all read', style: TextStyle(color: AppColors.primaryPurple, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState(context)
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationCard(context, index);
              },
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined, size: 80, color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey),
          const SizedBox(height: 16),
          Text(
            'No notifications yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDarkMode ? AppColors.darkText : AppColors.textDark),
          ),
          Text(
            'We\'ll notify you when something happens.',
            style: TextStyle(color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, int index) {
    final notification = _notifications[index];
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bool isRead = notification['isRead'];

    IconData iconData;
    Color iconColor;
    switch (notification['type']) {
      case 'sale':
        iconData = Icons.shopping_bag_outlined;
        iconColor = AppColors.successGreen;
        break;
      case 'inventory':
        iconData = Icons.inventory_2_outlined;
        iconColor = AppColors.accentOrange;
        break;
      default:
        iconData = Icons.info_outline;
        iconColor = AppColors.primaryPurple;
    }

    return Dismissible(
      key: Key(notification['title'] + index.toString()),
      onDismissed: (direction) {
        setState(() {
          _notifications.removeAt(index);
        });
      },
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(color: AppColors.errorRed, borderRadius: BorderRadius.circular(16)),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isRead ? Theme.of(context).cardColor : (isDarkMode ? AppColors.primaryPurple.withAlpha(40) : AppColors.primaryPurple.withAlpha(15)),
          borderRadius: BorderRadius.circular(16),
          border: isRead ? null : Border.all(color: AppColors.primaryPurple.withAlpha(100), width: 1),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor, size: 24),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  notification['title'],
                  style: TextStyle(
                    fontWeight: isRead ? FontWeight.w600 : FontWeight.w800,
                    fontSize: 15,
                    color: isDarkMode ? AppColors.darkText : AppColors.textDark,
                  ),
                ),
              ),
              Text(
                notification['time'],
                style: TextStyle(fontSize: 10, color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              notification['message'],
              style: TextStyle(
                fontSize: 13,
                color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey,
                height: 1.4,
              ),
            ),
          ),
          onTap: () {
            setState(() {
              _notifications[index]['isRead'] = true;
            });
          },
        ),
      ),
    );
  }
}
