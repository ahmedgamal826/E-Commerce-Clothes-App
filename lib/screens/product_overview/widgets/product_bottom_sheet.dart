import 'package:e_commerce_app/constants/app_colors.dart';
import 'package:e_commerce_app/screens/cart_screen/cart_screen.dart';
import 'package:flutter/material.dart';

class ProductBottomSheet {
  static void show(
    BuildContext context,
    double pricePerItem,
    String productName,
    String productImage,
    VoidCallback onCheckout,
  ) {
    String selectedSize = 'S';
    Color selectedColor = AppColors.primaryColor;
    int quantity = 1;
    double totalPrice = pricePerItem * quantity;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Size Section
                  const Text(
                    'Size',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ['S', 'M', 'L', 'XL'].map((size) {
                      return GestureDetector(
                        onTap: () {
                          setModalState(() {
                            selectedSize = size;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: selectedSize == size
                                ? Colors.grey[300]
                                : Colors.transparent,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              fontSize: 16,
                              color: selectedSize == size
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // Color Section
                  const Text(
                    'Color',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Colors.red,
                      Colors.green,
                      Colors.blue,
                      Colors.yellow,
                    ].map((color) {
                      return GestureDetector(
                        onTap: () {
                          setModalState(() {
                            selectedColor = color;
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                            border: selectedColor == color
                                ? Border.all(color: Colors.black, width: 2)
                                : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // Total Quantity Section
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) {
                            setModalState(() {
                              quantity--;
                              totalPrice = pricePerItem * quantity;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        quantity.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        onPressed: () {
                          setModalState(() {
                            quantity++;
                            totalPrice = pricePerItem * quantity;
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Total Payment Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Payment',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Checkout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        final cartItem = {
                          'name': productName,
                          'image': productImage,
                          'price': pricePerItem,
                          'quantity': quantity,
                        };
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartScreen(
                              cartItems: [cartItem],
                            ),
                          ),
                        );
                        onCheckout();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
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
                ],
              ),
            );
          },
        );
      },
    );
  }
}
