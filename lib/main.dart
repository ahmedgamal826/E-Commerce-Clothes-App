import 'package:e_commerce_app/screens/login%20screen/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ECommerceApp());
}

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor:
              Colors.red, // change hand cursor color in text field
        ),
      ),
    );
  }
}
