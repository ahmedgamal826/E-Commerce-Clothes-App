import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_commerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final double totalPrice;

  const PaymentScreen({Key? key, required this.totalPrice}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'Amazon Pay'; // طريقة الدفع الافتراضية

  @override
  Widget build(BuildContext context) {
    const double shippingFee = 15.00; // رسوم الشحن ثابتة
    final double subTotal = widget.totalPrice; // السعر الفرعي
    final double totalPayment = subTotal + shippingFee; // السعر الإجمالي

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
          'Product Overview',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Methods
            _buildPaymentOption(
              'Amazon Pay',
              'assets/images/amazon_pay_logo.png', // افترضنا مسار للصورة
              _selectedPaymentMethod == 'Amazon Pay',
              () {
                setState(() {
                  _selectedPaymentMethod = 'Amazon Pay';
                });
              },
            ),
            _buildPaymentOption(
              'Credit Card',
              'assets/images/credit_card_logo-removebg-preview (1).png', // افترضنا مسار للصورة
              _selectedPaymentMethod == 'Credit Card',
              () {
                setState(() {
                  _selectedPaymentMethod = 'Credit Card';
                });
              },
            ),
            _buildPaymentOption(
              'PayPal',
              'assets/images/paypal_logo.png', // افترضنا مسار للصورة
              _selectedPaymentMethod == 'PayPal',
              () {
                setState(() {
                  _selectedPaymentMethod = 'PayPal';
                });
              },
            ),
            _buildPaymentOption(
              'Google Pay',
              'assets/images/google_pay_logo.png', // افترضنا مسار للصورة
              _selectedPaymentMethod == 'Google Pay',
              () {
                setState(() {
                  _selectedPaymentMethod = 'Google Pay';
                });
              },
            ),
            const Spacer(),
            // Price Details
            _buildPriceRow('Sub-Total', subTotal),
            _buildPriceRow('Shipping Fee', shippingFee),
            const Divider(
              color: Colors.black,
              thickness: 2,
            ),
            _buildPriceRow('Total Payment', totalPayment, isTotal: true),
            const SizedBox(height: 16),
            // Confirm Payment Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showConfirmationDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Confirm Payment',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
      String title, String logoPath, bool isSelected, VoidCallback onTap) {
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
              Radio(
                value: title,
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value.toString();
                  });
                },
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
                // errorBuilder: (context, error, stackTrace) {
                //   return const SizedBox(
                //     height: 30,
                //     width: 60,
                //     child: Center(child: Text('Logo')),
                //   );
                // },
              ),
            ],
          ),
        ),
      ),
    );
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
}
