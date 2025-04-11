// import 'package:e_commerce_app/constants/app_colors.dart';
// import 'package:e_commerce_app/screens/payment_screen/payment_screen.dart'; // استيراد PaymentScreen
// import 'package:flutter/material.dart';

// class CartScreen extends StatefulWidget {
//   final List<Map<String, dynamic>>? cartItems;

//   const CartScreen({Key? key, this.cartItems}) : super(key: key);

//   @override
//   _CartScreenState createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   late List<bool> _selectedItems;
//   late List<Map<String, dynamic>> _cartItems;
//   double _totalPrice = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _cartItems = List.from(widget.cartItems ?? []);
//     _selectedItems = List<bool>.filled(_cartItems.length, true);
//     _calculateTotalPrice();
//   }

//   void _calculateTotalPrice() {
//     setState(() {
//       _totalPrice = _cartItems
//           .asMap()
//           .entries
//           .where((entry) => _selectedItems[entry.key])
//           .map((entry) => entry.value['price'] * entry.value['quantity'])
//           .fold(0.0, (prev, curr) => prev + curr);
//     });
//   }

//   void _toggleSelectAll(bool? value) {
//     setState(() {
//       _selectedItems = List.filled(_selectedItems.length, value ?? false);
//       _calculateTotalPrice();
//     });
//   }

//   void _removeItem(int index) {
//     setState(() {
//       _cartItems.removeAt(index);
//       _selectedItems.removeAt(index);
//       _calculateTotalPrice();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Cart',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: _cartItems.isEmpty
//                 ? const Center(child: Text('Your cart is empty'))

//                 :
//                 // : ListView.builder(
//                 //     itemCount: _cartItems.length,
//                 //     itemBuilder: (context, index) {
//                 //       final item = _cartItems[index];
//                 //       return Dismissible(
//                 //         key: Key(item['name'].toString() + index.toString()),
//                 //         direction: DismissDirection.endToStart,
//                 //         background: Container(
//                 //           color: Colors.red,
//                 //           alignment: Alignment.centerRight,
//                 //           padding: const EdgeInsets.only(right: 20),
//                 //           child: const Icon(Icons.delete, color: Colors.white),
//                 //         ),
//                 //         onDismissed: (_) => _removeItem(index),
//                 //         child: Padding(
//                 //           padding: const EdgeInsets.symmetric(
//                 //               vertical: 8.0, horizontal: 16.0),
//                 //           child: Row(
//                 //             children: [
//                 //               Checkbox(
//                 //                 value: _selectedItems[index],
//                 //                 onChanged: (bool? value) {
//                 //                   setState(() {
//                 //                     _selectedItems[index] = value ?? false;
//                 //                     _calculateTotalPrice();
//                 //                   });
//                 //                 },
//                 //                 activeColor: AppColors.primaryColor,
//                 //               ),
//                 //               ClipRRect(
//                 //                 borderRadius: BorderRadius.circular(10),
//                 //                 child: Image.asset(
//                 //                   item['image'],
//                 //                   width: 60,
//                 //                   height: 60,
//                 //                   fit: BoxFit.cover,
//                 //                   errorBuilder: (context, error, stackTrace) =>
//                 //                       Container(
//                 //                     width: 60,
//                 //                     height: 60,
//                 //                     color: Colors.grey[300],
//                 //                     child:
//                 //                         const Icon(Icons.image_not_supported),
//                 //                   ),
//                 //                 ),
//                 //               ),
//                 //               const SizedBox(width: 16),
//                 //               Expanded(
//                 //                 child: Column(
//                 //                   crossAxisAlignment: CrossAxisAlignment.start,
//                 //                   children: [
//                 //                     Text(
//                 //                       item['name'],
//                 //                       style: const TextStyle(
//                 //                         fontSize: 16,
//                 //                         fontWeight: FontWeight.bold,
//                 //                       ),
//                 //                     ),
//                 //                     Text(
//                 //                       '\$${item['price'].toStringAsFixed(2)}',
//                 //                       style: const TextStyle(
//                 //                         fontSize: 16,
//                 //                         fontWeight: FontWeight.bold,
//                 //                         color: AppColors.primaryColor,
//                 //                       ),
//                 //                     ),
//                 //                   ],
//                 //                 ),
//                 //               ),
//                 //               Row(
//                 //                 children: [
//                 //                   IconButton(
//                 //                     onPressed: () {
//                 //                       setState(() {
//                 //                         if (item['quantity'] > 1) {
//                 //                           item['quantity']--;
//                 //                           _calculateTotalPrice();
//                 //                         }
//                 //                       });
//                 //                     },
//                 //                     icon: const Icon(Icons.remove,
//                 //                         color: Colors.green),
//                 //                   ),
//                 //                   Text(
//                 //                     item['quantity'].toString(),
//                 //                     style: const TextStyle(fontSize: 16),
//                 //                   ),
//                 //                   IconButton(
//                 //                     onPressed: () {
//                 //                       setState(() {
//                 //                         item['quantity']++;
//                 //                         _calculateTotalPrice();
//                 //                       });
//                 //                     },
//                 //                     icon: const Icon(Icons.add,
//                 //                         color: Colors.green),
//                 //                   ),
//                 //                 ],
//                 //               ),
//                 //             ],
//                 //           ),
//                 //         ),
//                 //       );
//                 //     },
//                 //   ),
//           ),
//           Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             child: Row(
//               children: [
//                 const Text(
//                   'Select All',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 const Spacer(),
//                 Checkbox(
//                   value: _selectedItems.every((selected) => selected),
//                   onChanged: _cartItems.isEmpty ? null : _toggleSelectAll,
//                   activeColor: AppColors.primaryColor,
//                 ),
//               ],
//             ),
//           ),
//           const Divider(
//               color: Colors.black, thickness: 2, endIndent: 20, indent: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Total Payment',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   '\$${_totalPrice.toStringAsFixed(2)}',
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 16),
//           Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             child: SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _cartItems.isEmpty || _totalPrice == 0
//                     ? null // تعطيل الزر إذا كانت السلة فارغة أو السعر 0
//                     : () {
//                         // الانتقال إلى PaymentScreen مع تمرير السعر الإجمالي
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => PaymentScreen(
//                               totalPrice: _totalPrice,
//                             ),
//                           ),
//                         );
//                       },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primaryColor,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 child: const Text(
//                   'Checkout',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// cart_screen.dart

import 'package:e_commerce_app/constants/app_colors.dart';
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
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
          ),
        ],
      ),
    );
  }
}
