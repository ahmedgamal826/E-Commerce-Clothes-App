import 'package:e_commerce_app/constants/app_colors.dart';
import 'package:e_commerce_app/screens/product_overview/product_overview.dart';
import 'package:flutter/material.dart';

class CustomDotIndicator extends StatelessWidget {
  const CustomDotIndicator({
    super.key,
    required this.widget,
    required this.screenWidth,
    required int currentPage,
  }) : _currentPage = currentPage;

  final ProductOverviewScreen widget;
  final double screenWidth;
  final int _currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.products.length, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
          child: CircleAvatar(
            radius: screenWidth * 0.015,
            backgroundColor: index == _currentPage
                ? AppColors.primaryColor
                : Colors.grey[300],
          ),
        );
      }),
    );
  }
}
