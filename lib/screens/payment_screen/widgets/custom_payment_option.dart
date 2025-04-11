// custom_payment_option.dart

import 'package:e_commerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomPaymentOption extends StatelessWidget {
  final String title;
  final String logoPath;
  final bool isSelected;
  final VoidCallback onTap;
  final ValueChanged<String?> onChanged;
  final String groupValue;

  const CustomPaymentOption({
    super.key,
    required this.title,
    required this.logoPath,
    required this.isSelected,
    required this.onTap,
    required this.onChanged,
    required this.groupValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? AppColors.primaryColor : Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Radio<String>(
                value: title,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: AppColors.primaryColor,
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
              const Spacer(),
              Image.asset(
                logoPath,
                height: 50,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 30,
                    width: 60,
                    child: Center(child: Text('Logo')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
