import 'package:e_commerce_app/constants/app_colors.dart';
import 'package:e_commerce_app/screens/home_screen/home_screen.dart';
import 'package:e_commerce_app/screens/login%20screen/widgets/custom_text_field.dart';
import 'package:e_commerce_app/screens/login%20screen/widgets/login_button.dart';
import 'package:e_commerce_app/screens/register%20screen/register_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

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
                const SizedBox(height: 100),
                Image.asset(
                  'assets/images/login_logo.jpg',
                  height: 150,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 60),
                const CustomTextField(
                  hintText: 'Enter Email',
                  prefixIcon: Icons.person,
                  keyTextInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Enter Password',
                  prefixIcon: Icons.lock,
                  keyTextInputType: TextInputType.text,
                  obscureText: _obscureText,
                  suffixIcon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onSuffixIconPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                const SizedBox(height: 10),
                // نص Forgot Password
                GestureDetector(
                  onTap: () {},
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                LoginButton(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
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
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
