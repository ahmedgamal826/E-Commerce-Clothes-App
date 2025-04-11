// custom_cart_list_view.dart

import 'package:e_commerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCartListView extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final List<bool> selectedItems;
  final ValueChanged<int> onRemoveItem;
  final ValueChanged<MapEntry<int, bool>> onSelectItem;
  final ValueChanged<MapEntry<int, int>> onQuantityChanged;

  const CustomCartListView({
    super.key,
    required this.cartItems,
    required this.selectedItems,
    required this.onRemoveItem,
    required this.onSelectItem,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        return Dismissible(
          key: Key('${item['name']}$index'),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (_) => onRemoveItem(index),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: [
                Checkbox(
                  value: selectedItems[index],
                  onChanged: (bool? value) {
                    onSelectItem(MapEntry(index, value ?? false));
                  },
                  activeColor: AppColors.primaryColor,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    item['image'],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 60,
                      height: 60,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${item['price'].toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (item['quantity'] > 1) {
                          onQuantityChanged(
                              MapEntry(index, item['quantity'] - 1));
                        }
                      },
                      icon: const Icon(Icons.remove, color: Colors.green),
                    ),
                    Text(
                      item['quantity'].toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      onPressed: () {
                        onQuantityChanged(
                            MapEntry(index, item['quantity'] + 1));
                      },
                      icon: const Icon(Icons.add, color: Colors.green),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
