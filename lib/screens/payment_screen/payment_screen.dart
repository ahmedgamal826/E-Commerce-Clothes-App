import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_commerce_app/constants/app_colors.dart';
import 'package:e_commerce_app/screens/payment_screen/widgets/custom_confirm_payment_button.dart';
import 'package:e_commerce_app/screens/payment_screen/widgets/custom_payment_option.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final double totalPrice;

  const PaymentScreen({Key? key, required this.totalPrice}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'Amazon Pay';

  void _showConfirmationDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      title: 'Purchase Completed',
      desc: 'Thank you for your purchase!',
      btnOkOnPress: () {
        Navigator.pop(context); // Go back after confirming
      },
    ).show();
  }

  Widget _buildPriceRow(String title, double price, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '\$${price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppColors.primaryColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double shippingFee = 15.00;
    final double subTotal = widget.totalPrice;
    final double totalPayment = subTotal + shippingFee;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Payment',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomPaymentOption(
                title: 'Amazon Pay',
                logoPath: 'assets/images/amazon_pay_logo.png',
                isSelected: _selectedPaymentMethod == 'Amazon Pay',
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = 'Amazon Pay';
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value ?? 'Amazon Pay';
                  });
                },
                groupValue: _selectedPaymentMethod,
              ),
              CustomPaymentOption(
                title: 'Credit Card',
                logoPath:
                    'assets/images/credit_card_logo-removebg-preview (1).png',
                isSelected: _selectedPaymentMethod == 'Credit Card',
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = 'Credit Card';
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value ?? 'Credit Card';
                  });
                },
                groupValue: _selectedPaymentMethod,
              ),

              CustomPaymentOption(
                title: 'PayPal',
                logoPath: 'assets/images/paypal_logo.png',
                isSelected: _selectedPaymentMethod == 'PayPal',
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = 'PayPal';
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value ?? 'PayPal';
                  });
                },
                groupValue: _selectedPaymentMethod,
              ),
              CustomPaymentOption(
                title: 'Google Pay',
                logoPath: 'assets/images/google_pay_logo.png',
                isSelected: _selectedPaymentMethod == 'Google Pay',
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = 'Google Pay';
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value ?? 'Google Pay';
                  });
                },
                groupValue: _selectedPaymentMethod,
              ),
              const SizedBox(height: 24),
              const Text(
                'Price Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildPriceRow('Sub-Total', subTotal),
              _buildPriceRow('Shipping Fee', shippingFee),
              const Divider(
                color: Colors.black,
                thickness: 2,
              ),
              _buildPriceRow('Total Payment', totalPayment, isTotal: true),
              const SizedBox(height: 16),
              CustomConfirmPaymentButton(
                onPressed: () {
                  _showConfirmationDialog(context);
                },
              ),
              const SizedBox(height: 16), // Extra padding at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
