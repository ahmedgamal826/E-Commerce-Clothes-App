import 'package:e_commerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class HomeSearchTextField extends StatelessWidget {
  const HomeSearchTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        cursorColor: Colors.black,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.primaryColor,
          ),
          hintText: 'Find Your Product',
          hintStyle: const TextStyle(
            color: AppColors.primaryColor,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
