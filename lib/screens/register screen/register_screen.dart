import 'package:e_commerce_app/constants/app_colors.dart';
import 'package:e_commerce_app/screens/home_screen/home_screen.dart';
import 'package:e_commerce_app/screens/login%20screen/login_screen.dart';
import 'package:e_commerce_app/screens/login%20screen/widgets/custom_text_field.dart';
import 'package:e_commerce_app/screens/register%20screen/widgets/create_account_button.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Image.asset(
                  'assets/images/login_logo.jpg',
                  height: 150,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 60),
                // Name TextField
                const CustomTextField(
                  hintText: 'Enter Name',
                  prefixIcon: Icons.person,
                  keyTextInputType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                // Email TextField
                const CustomTextField(
                  hintText: 'Enter Email',
                  prefixIcon: Icons.email,
                  keyTextInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                // Phone Number TextField
                const CustomTextField(
                  hintText: 'Phone Number',
                  prefixIcon: Icons.phone,
                  keyTextInputType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                // Password TextField
                CustomTextField(
                  hintText: 'Enter Password',
                  prefixIcon: Icons.lock,
                  keyTextInputType: TextInputType.text,
                  obscureText: _obscurePassword,
                  suffixIcon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onSuffixIconPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                const SizedBox(height: 20),
                // Confirm Password TextField
                CustomTextField(
                  keyTextInputType: TextInputType.text,
                  hintText: 'Confirm Password',
                  prefixIcon: Icons.lock,
                  obscureText: _obscureConfirmPassword,
                  suffixIcon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onSuffixIconPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CreateAccountButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                // نص Already have an account? Sign In
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
