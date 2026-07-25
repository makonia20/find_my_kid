// ignore_for_file: unused_local_variable, unused_field

import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'signup_screen.dart';
import 'forget_password_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  String _selectedRole = 'parent'; // default role
  String _countryCode = '+1'; // default country code
  String _flag = '🇺🇸'; // default flag
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _onRoleChanged(String? value) {
    if (value != null) {
      setState(() {
        _selectedRole = value;
      });
    }
  }

  void _onCountryChange(CountryCode countryCode) {
    setState(() {
      _countryCode = countryCode.dialCode ?? '+1';
      _flag = countryCode.flagEmoji ?? '🇺🇸';
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validatePhoneNumber(String phone) {
    final RegExp regExp = RegExp(r'^\d{9}$');
    return regExp.hasMatch(phone);
  }

  void _login() {
    final phone = _phoneController.text.trim();
    final password = _passwordController.text;

    if (!_validatePhoneNumber(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone number must be 9 digits')),
      );
      return;
    }

    // TODO: Call backend API for login with _countryCode, phone, password, and _selectedRole

    if (_selectedRole == 'parent') {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      Navigator.pushReplacementNamed(context, '/child-dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF2F6FF,
      ), // Changed to match signup screen
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              // App Logo
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF6366F1)],
                  ),
                ),
                child: const Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              const SizedBox(height: 20),
              // App Name
              Text(
                'find my Kid\'s Phone',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 40),

              // Role Selection
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<String>(
                    value: 'parent',
                    groupValue: _selectedRole,
                    onChanged: _onRoleChanged,
                  ),
                  const Text('Parent'),
                  const SizedBox(width: 20),
                  Radio<String>(
                    value: 'child',
                    groupValue: _selectedRole,
                    onChanged: _onRoleChanged,
                  ),
                  const Text('Child'),
                ],
              ),
              const SizedBox(height: 20),

              // Country Code Picker and Phone Number Input
              Row(
                children: [
                  CountryCodePicker(
                    onChanged: _onCountryChange,
                    initialSelection: 'US',
                    favorite: const ['+1', 'US'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Password Input
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Colors.blue.shade800),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.blue.shade800,
                    ),
                    onPressed: _toggleObscure,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: const Color(0xFF3B82F6),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Forgot Password and Create Account
              Column(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        color: Color(0xFF6366F1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      // Navigate to ForgetPasswordPage with dummy mobile number for now
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => const ForgetPasswordPage(
                                mobileNumber: '123-456-7890',
                              ),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.red.shade400,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  '© 2024 find my Kid\'s Phone. All rights reserved.',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on CountryCode {
  get flagEmoji => null;
}
