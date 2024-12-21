import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with blue background and white title text
      appBar: AppBar(
        title: const Text('Sign In'),
        backgroundColor: Colors.blue, // Blue background
        titleTextStyle: const TextStyle(
          color: Colors.white, // White text
          fontSize: 24, // Font size
          fontWeight: FontWeight.bold, // Bold text
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Email input field with blue label and border
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.blue), // Blue label text
                  fillColor: Colors.white, // White background for input field
                  filled: true, // Make the background filled
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue), // Blue border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue), // Focused blue border
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Password input field with blue label and border
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.blue), // Blue label text
                  fillColor: Colors.white, // White background for input field
                  filled: true, // Make the background filled
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue), // Blue border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue), // Focused blue border
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Sign In button with blue background and white text
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sign In Successful'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Blue background for button
                  foregroundColor: Colors.white, // White text color
                ),
                child: Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
