import 'package:e_commerce_app/constants/app_colors.dart';
import 'package:e_commerce_app/screens/cart_screen/widgets/cart_checkout_button.dart';
import 'package:e_commerce_app/screens/cart_screen/widgets/custom_cart_list_view.dart';
import 'package:e_commerce_app/screens/payment_screen/payment_screen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? cartItems;

  const CartScreen({Key? key, this.cartItems}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<bool> _selectedItems;
  late List<Map<String, dynamic>> _cartItems;
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _cartItems = List.from(widget.cartItems ?? []);
    _selectedItems = List<bool>.filled(_cartItems.length, true);
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    setState(() {
      _totalPrice = _cartItems
          .asMap()
          .entries
          .where((entry) => _selectedItems[entry.key])
          .map((entry) => entry.value['price'] * entry.value['quantity'])
          .fold(0.0, (prev, curr) => prev + curr);
    });
  }

  void _toggleSelectAll(bool? value) {
    setState(() {
      _selectedItems = List.filled(_selectedItems.length, value ?? false);
      _calculateTotalPrice();
    });
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
      _selectedItems.removeAt(index);
      _calculateTotalPrice();
    });
  }

  void _onSelectItem(MapEntry<int, bool> entry) {
    setState(() {
      _selectedItems[entry.key] = entry.value;
      _calculateTotalPrice();
    });
  }

  void _onQuantityChanged(MapEntry<int, int> entry) {
    setState(() {
      _cartItems[entry.key]['quantity'] = entry.value;
      _calculateTotalPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: _cartItems.isEmpty
                ? const Center(child: Text('Your cart is empty'))
                : CustomCartListView(
                    cartItems: _cartItems,
                    selectedItems: _selectedItems,
                    onRemoveItem: _removeItem,
                    onSelectItem: _onSelectItem,
                    onQuantityChanged: _onQuantityChanged,
                  ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                const Text(
                  'Select All',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Checkbox(
                  value: _selectedItems.every((selected) => selected),
                  onChanged: _cartItems.isEmpty ? null : _toggleSelectAll,
                  activeColor: AppColors.primaryColor,
                ),
              ],
            ),
          ),
          const Divider(
              color: Colors.black, thickness: 2, endIndent: 20, indent: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Payment',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${_totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CartCheckoutButton(
            cartItems: _cartItems,
            totalPrice: _totalPrice,
          ),
        ],
      ),
    );
  }
}
