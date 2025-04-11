import 'package:e_commerce_app/constants/app_colors.dart';
import 'package:e_commerce_app/screens/product_overview/product_overview.dart';
import 'package:e_commerce_app/screens/product_overview/widgets/product_bottom_sheet.dart';
import 'package:flutter/material.dart';

class BuyNowButton extends StatelessWidget {
  const BuyNowButton({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.widget,
    required int currentPage,
    required this.buttonPaddingHorizontal,
    required this.buttonPaddingVertical,
  }) : _currentPage = currentPage;

  final double screenWidth;
  final double screenHeight;
  final ProductOverviewScreen widget;
  final int _currentPage;
  final double buttonPaddingHorizontal;
  final double buttonPaddingVertical;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * 0.7,
      height: screenHeight * 0.07,
      child: ElevatedButton(
        onPressed: () {
          ProductBottomSheet.show(
            context,
            widget.products[_currentPage]['price'],
            widget.products[_currentPage]['name'],
            widget.products[_currentPage]['image'],
            () {
              print("Checkout pressed from Bottom Sheet!");
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.symmetric(
            horizontal: buttonPaddingHorizontal,
            vertical: buttonPaddingVertical,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
          ),
        ),
        child: Text(
          'Buy Now',
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
