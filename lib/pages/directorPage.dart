import 'package:flutter/material.dart';

class DirectorPage extends StatelessWidget {
  const DirectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Change the background color here
      body: Stack(
        clipBehavior: Clip.none, // Allow content to overflow the screen boundaries
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 50, // Adjust padding for top section
              bottom: MediaQuery.of(context).size.height * .35 + 50,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // App Name "InstaCall"
                  const Text(
                    'InstaCall', // App name
                    style: TextStyle(
                      fontSize: 50, // Large font size for the app name
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 1),
                  // Slogan
                  const Text(
                    'Quick Help. Anytime. Anywhere.', // Slogan text
                    style: TextStyle(
                      fontSize: 20, // Smaller font size for the slogan
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {}, // Provide an empty callback to enable the button
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Increase button padding
                      minimumSize: const Size(200, 60), // Set minimum size (width, height)
                    ),
                    child: const Text(
                      'Sign In', // Corrected button text
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {}, // Provide an empty callback to enable the button
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Increase button padding
                      minimumSize: const Size(200, 60), // Set minimum size (width, height)
                    ),
                    child: const Text(
                      'Sign Up', // Corrected button text
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width * 1.5, // Adjust width (increased to 150% of screen width)
              height: MediaQuery.of(context).size.height * .45, // Adjust height
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(MediaQuery.of(context).size.height), // Adjust radius for ellipse
                ),
              ),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1.5, // Set width for the "Emergency" button
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 0,
                    ),
                    child: const Text(
                      'Emergency',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
