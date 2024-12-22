import 'dart:io';
// import 'package:permission_handler/permission_handler.dart'; // Import permission_handler
import 'package:emergencyapp/pages/signIn.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor:
      Colors.white, // Set background color of the screen to white
      body: Column(
        mainAxisAlignment:
        MainAxisAlignment.center, // Center the widgets vertically
        children: [
          // 'Medical Professional' button
          SizedBox(
            width: screenWidth, // Set width to full screen width
            height: (screenHeight / 2) -
                40, // Set height to half of screen height minus padding
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the next page with 'Medical Professional' role
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SignUpFormPage(role: 'Medical Professional'),
                  ),
                );
              },
              child: Text(
                'Medical\nProfessional', // Adds a line break between 'Medical' and 'Professional'
                textAlign: TextAlign.center, // Center the text horizontally
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                  fontSize: 40, // Set font size
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Set background color to blue
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius
                      .zero, // Remove border radius for square corners
                ),
              ),
            ),
          ),
          SizedBox(height: 20), // Space between buttons and text
          // Centered text 'Select Your Role'
          Text(
            'Select Your Role',
            style: TextStyle(
              color: Colors.blue, // Text color
              fontSize: 24, // Font size
              fontWeight: FontWeight.bold, // Bold text
            ),
          ),
          SizedBox(height: 20), // Space between text and 'User' button
          // 'User' button
          SizedBox(
            width: screenWidth, // Set width to full screen width
            height: (screenHeight / 2) -
                40, // Set height to half of screen height minus padding
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
              child: Text(
                'User',
                textAlign: TextAlign.center, // Center the text horizontally
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                  fontSize: 60, // Set font size
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Set background color to green
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius
                      .zero, // Remove border radius for square corners
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
  SignUpFormPage({required this.role});

  @override
  _SignUpFormPageState createState() => _SignUpFormPageState();
}

class _SignUpFormPageState extends State<SignUpFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _last_nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _specialtyController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  PlatformFile? _verificationFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up - ${widget.role}'),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.blue,
      ),
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
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    labelStyle: TextStyle(color: Colors.blue),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  style: TextStyle(color: Colors.blue),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _last_nameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: TextStyle(color: Colors.blue),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  style: TextStyle(color: Colors.blue),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.blue),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  style: TextStyle(color: Colors.blue),
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
                SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(color: Colors.blue),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  style: TextStyle(color: Colors.blue),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.blue),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  style: TextStyle(color: Colors.blue),
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
                SizedBox(height: 20),

                // Medical Professional specific fields
                if (widget.role == 'Medical Professional') ...[
                  TextFormField(
                    controller: _specialtyController,
                    decoration: InputDecoration(
                      labelText: 'Medical Specialty',
                      labelStyle: TextStyle(color: Colors.blue),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    style: TextStyle(color: Colors.blue),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your medical specialty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _experienceController,
                    decoration: InputDecoration(
                      labelText: 'Years of Experience',
                      labelStyle: TextStyle(color: Colors.blue),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    style: TextStyle(color: Colors.blue),
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
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles();
                      if (result != null) {
                        setState(() {
                          _verificationFile = result.files.first;
                        });
                      }
                    },
                    child: Text('Upload Verification Document'),
                  ),
                  if (_verificationFile != null)
                    Text('Selected File: ${_verificationFile!.name}'),
                ],
                SizedBox(height: 20),


                // Submit button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data...')),
                      );

                      try {
                        final response =
                        await Supabase.instance.client.auth.signUp(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );

                        if (response.user != null) {
// Sign up successful
                          final userId = response.user!.id;

// Prepare common user data
                          final userData = {
                            'first_name': _nameController.text,
                            'last_name': _last_nameController.text,
                            'email': _emailController.text,
                            'phone_num': _phoneController.text,
                          };

                          String? fileUrl;
                          if (_verificationFile != null) {
                            try {
                              final uploadPath = 'documents/${_verificationFile!.name}';

                              if (kIsWeb) {
                                // For web, use bytes
                                await Supabase.instance.client.storage
                                    .from('verifications')
                                    .uploadBinary(uploadPath, _verificationFile!.bytes!);
                              } else {
                                // For mobile, use File
                                await Supabase.instance.client.storage
                                    .from('verifications')
                                    .upload(uploadPath, File(_verificationFile!.path!));
                              }

                              fileUrl = Supabase.instance.client.storage
                                  .from('verifications')
                                  .getPublicUrl(uploadPath);

                            } catch (e) {
                              throw Exception('File upload failed: $e');
                            }
                          }
                          // if (_verificationFile != null) {
                          //   try {
                          //     final uploadPath = 'documents/${_verificationFile!.name}';
                          //
                          //     // Upload the file
                          //     await Supabase.instance.client.storage
                          //         .from('verifications')
                          //         .upload(uploadPath, File(_verificationFile!.path!));
                          //
                          //     // Get the public URL of the uploaded file
                          //     fileUrl = Supabase.instance.client.storage
                          //         .from('verifications')
                          //         .getPublicUrl(uploadPath);
                          //
                          //   } catch (e) {
                          //     throw Exception('File upload failed: $e');
                          //   }
                          // }

                          if (widget.role == 'Medical Professional') {
// Add doctor-specific data
                            final doctorData = {
                              'speciality': _specialtyController.text,
                              'experience': _experienceController.text,
                              'verification': fileUrl, // Include file URL

                            };

// Insert into 'doctor' table
                            final insertResponse = await Supabase
                                .instance.client
                                .from('doctor')
                                .insert([
                              {
                                'doctor_id': userId,
                                'first_name': userData['first_name'],
                                'last_name': userData['last_name'],
                                'email': userData['email'],
                                'phone_no': userData['phone_num'],
                                'password': _passwordController.text,
                                ...doctorData,
                              }
                            ]);

                            if (insertResponse.error != null) {
                              throw Exception(insertResponse.error.message);
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Sign Up Successful')),
                            );
                            Navigator.pop(context);
                          } else {
                            // Insert into 'user' table
                            final insertResponse = await Supabase
                                .instance.client
                                .from('user')
                                .insert([
                              {
                                'user_id': userId,
                                ...userData,
                                'password': _passwordController.text,
                              }
                            ]);

                            if (insertResponse.error != null) {
                              throw Exception(insertResponse.error.message);
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Sign Up Successful'),
                                backgroundColor: Colors.green,

                              ),
                            );
                            Navigator.pop(context);
                          }
                        } else {
                          throw Exception('User not created successfully');
                        }
                      } catch (e) {
                        if (e.toString().contains("NoSuchMethodError:")) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Sign Up Successful'),
                                backgroundColor: Colors.green
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${e.toString()}'),
                              backgroundColor: Colors.red,

                            ),
                          );
                        }
                      }
                    }
                  },
                  child: Text('Sign Up'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white),
                ),
                SizedBox(height: 20),

                ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SignInPage()), // Fixed navigation
                      );
                    },
                    child: Text('Sign In'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

