import 'package:e_commerce_app/constants/app_colors.dart';
import 'package:e_commerce_app/screens/payment_screen/payment_screen.dart';
import 'package:flutter/material.dart';

class CartCheckoutButton extends StatelessWidget {
  const CartCheckoutButton({
    super.key,
    required List<Map<String, dynamic>> cartItems,
    required double totalPrice,
  })  : _cartItems = cartItems,
        _totalPrice = totalPrice;

  final List<Map<String, dynamic>> _cartItems;
  final double _totalPrice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _cartItems.isEmpty || _totalPrice == 0
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                        totalPrice: _totalPrice,
                      ),
                    ),
                  );
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            'Checkout',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
