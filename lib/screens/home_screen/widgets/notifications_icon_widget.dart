import 'package:e_commerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class NotificationsIconWidget extends StatelessWidget {
  const NotificationsIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.0650,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: const Icon(Icons.notifications, color: AppColors.primaryColor),
        onPressed: () {},
      ),
    );
  }
}
