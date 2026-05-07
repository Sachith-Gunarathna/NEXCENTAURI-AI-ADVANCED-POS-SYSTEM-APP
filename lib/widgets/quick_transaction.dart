import 'package:flutter/material.dart';
import '../theme/colors.dart';

class QuickTransaction extends StatelessWidget {
  const QuickTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    final List<Map<String, String>> contacts = [
      {'name': 'Add', 'icon': 'add'},
      {'name': 'Raul', 'image': 'https://i.pravatar.cc/150?u=1'},
      {'name': 'Winpter', 'image': 'https://i.pravatar.cc/150?u=2'},
      {'name': 'Winter', 'image': 'https://i.pravatar.cc/150?u=3'},
      {'name': 'Winter', 'image': 'https://i.pravatar.cc/150?u=4'},
      {'name': 'Winter', 'image': 'https://i.pravatar.cc/150?u=5'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Transaction',
          style: TextStyle(
            color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: contacts.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return Column(
                children: [
                  if (contact.containsKey('icon'))
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isDarkMode ? AppColors.primaryPurple : AppColors.primaryPurple, 
                          style: BorderStyle.solid
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, color: AppColors.primaryPurple),
                    )
                  else
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(contact['image']!),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    contact['name']!,
                    style: TextStyle(
                      fontSize: 12, 
                      color: isDarkMode ? AppColors.darkTextGrey : AppColors.textGrey
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
