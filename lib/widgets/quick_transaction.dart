import 'package:flutter/material.dart';
import '../theme/colors.dart';

class QuickTransaction extends StatelessWidget {
  const QuickTransaction({super.key});

  @override
  Widget build(BuildContext context) {
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
        const Text(
          'Quick Transaction',
          style: TextStyle(
            color: AppColors.textGrey,
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
                        border: Border.all(color: AppColors.primaryGreen, style: BorderStyle.solid),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, color: AppColors.primaryGreen),
                    )
                  else
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(contact['image']!),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    contact['name']!,
                    style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
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
