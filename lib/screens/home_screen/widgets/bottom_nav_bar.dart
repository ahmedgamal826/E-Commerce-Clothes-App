import 'package:e_commerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10.0,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home_outlined,
                  color:
                      selectedIndex == 0 ? AppColors.primaryColor : Colors.grey,
                ),
                onPressed: () => onItemTapped(0),
              ),
              const SizedBox(width: 30),
              IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color:
                      selectedIndex == 1 ? AppColors.primaryColor : Colors.grey,
                ),
                onPressed: () => onItemTapped(1),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.favorite_outline,
                  color:
                      selectedIndex == 2 ? AppColors.primaryColor : Colors.grey,
                ),
                onPressed: () => onItemTapped(2),
              ),
              const SizedBox(width: 30),
              IconButton(
                icon: Icon(
                  Icons.person_pin,
                  color:
                      selectedIndex == 3 ? AppColors.primaryColor : Colors.grey,
                ),
                onPressed: () => onItemTapped(3),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
