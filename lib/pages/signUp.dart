import 'dart:io';
// import 'package:permission_handler/permission_handler.dart'; // Import permission_handler
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white, // Set background color of the screen to white
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center the widgets vertically
        children: [
          // 'Medical Professional' button
          SizedBox(
            width: screenWidth, // Set width to full screen width
            height: (screenHeight / 2) - 40, // Set height to half of screen height minus padding
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the next page with 'Medical Professional' role
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpFormPage(role: 'Medical Professional'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Set background color to blue
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // Remove border radius for square corners
                ),
              ),
              child: Text(
                'Medical\nProfessional', // Adds a line break between 'Medical' and 'Professional'
                textAlign: TextAlign.center, // Center the text horizontally
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                  fontSize: 40, // Set font size
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
              ),
            ),
          ),
          const SizedBox(height: 20), // Space between buttons and text
          // Centered text 'Select Your Role'
          const Text(
            'Select Your Role',
            style: TextStyle(
              color: Colors.blue, // Text color
              fontSize: 24, // Font size
              fontWeight: FontWeight.bold, // Bold text
            ),
          ),
          const SizedBox(height: 20), // Space between text and 'User' button
          // 'User' button
          SizedBox(
            width: screenWidth, // Set width to full screen width
            height: (screenHeight / 2) - 40, // Set height to half of screen height minus padding
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the next page with 'User' role
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpFormPage(role: 'User'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Set background color to green
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // Remove border radius for square corners
                ),
              ),
              child: Text(
                'User',
                textAlign: TextAlign.center, // Center the text horizontally
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                  fontSize: 60, // Set font size
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpFormPage extends StatefulWidget {
  final String role;

  // Constructor to accept role as a parameter
  const SignUpFormPage({super.key, required this.role});

  @override
  _SignUpFormPageState createState() => _SignUpFormPageState();
}

class _SignUpFormPageState extends State<SignUpFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _specialtyController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // For picking the license verification image
  // final ImagePicker _picker = ImagePicker();
  // XFile? _licenseImage;
  //
  // // Function to pick license verification image
  // Future<void> _pickLicenseImage() async {
  //   // Request storage permission
  //   PermissionStatus permission = await Permission.storage.request();
  //
  //   if (permission.isGranted) {
  //     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //     if (pickedFile != null) {
  //       setState(() {
  //         _licenseImage = pickedFile;
  //       });
  //     }
  //   } else {
  //     // Show an error message if permission is not granted
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Permission denied. Cannot pick image.')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Set the background color of the screen to blue
      appBar: AppBar(title: Text('Sign Up - ${widget.role}'),titleTextStyle: const TextStyle(
        color: Colors.white, // Change the text color of the AppBar title
        fontSize: 24, // Font size
        fontWeight: FontWeight.bold, // Font weight
      ), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Common fields for both User and Medical Professional
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.blue), // Blue label text
                    fillColor: Colors.white, // White background for the text field
                    filled: true, // Make the background color filled
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  style: const TextStyle(color: Colors.blue), // Blue text color
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.blue), // Blue label text
                    fillColor: Colors.white, // White background for the text field
                    filled: true, // Make the background color filled
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  style: const TextStyle(color: Colors.blue), // Blue text color
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
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(color: Colors.blue), // Blue label text
                    fillColor: Colors.white, // White background for the text field
                    filled: true, // Make the background color filled
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  style: const TextStyle(color: Colors.blue), // Blue text color
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.blue), // Blue label text
                    fillColor: Colors.white, // White background for the text field
                    filled: true, // Make the background color filled
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  style: const TextStyle(color: Colors.blue), // Blue text color
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Medical Professional specific fields
                if (widget.role == 'Medical Professional') ...[
                  TextFormField(
                    controller: _specialtyController,
                    decoration: const InputDecoration(
                      labelText: 'Medical Specialty',
                      labelStyle: TextStyle(color: Colors.blue), // Blue label text
                      fillColor: Colors.white, // White background for the text field
                      filled: true, // Make the background color filled
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    style: const TextStyle(color: Colors.blue), // Blue text color
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your medical specialty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _experienceController,
                    decoration: const InputDecoration(
                      labelText: 'Years of Experience',
                      labelStyle: TextStyle(color: Colors.blue), // Blue label text
                      fillColor: Colors.white, // White background for the text field
                      filled: true, // Make the background color filled
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    style: const TextStyle(color: Colors.blue), // Blue text color
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your years of experience';
                      }
                      if (int.tryParse(value) == null || int.parse(value) < 0) {
                        return 'Enter a valid number of years';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Button for picking license image
                  // ElevatedButton(
                  //   onPressed: _pickLicenseImage,
                  //   child: Text('Pick License Image'),
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.white, // Set background color to white
                  //   ),
                  // ),
                  // if (_licenseImage != null)
                  //   Padding(
                  //     padding: const EdgeInsets.symmetric(vertical: 20),
                  //     child: Column(
                  //       children: [
                  //         Image.file(File(_licenseImage!.path)),
                  //         Text('Picked image: ${_licenseImage!.path}'),
                  //       ],
                  //     ),
                  //   ),
                ],

                // Submit button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Handle successful form submission
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data...')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Set background color to white
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
