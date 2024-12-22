import 'package:flutter/material.dart';
import 'pages/signIn.dart';  // Correct import for SignInPage
import 'pages/signUp.dart';  // Correct import for SignUpPage 
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/videocallindex.dart';

class DirectorPage extends StatelessWidget 
{

  const DirectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Background color
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
                  Text(
                    'InstaCare', // App name
                    style: TextStyle(
                      fontSize: 50, // Large font size for the app name
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 1),
                  // Slogan
                  Text(
                    'Quick Help. Anytime. Anywhere.', // Slogan text
                    style: TextStyle(
                      fontSize: 20, // Smaller font size for the slogan
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Sign In page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage()), // Fixed navigation
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      minimumSize: Size(200, 60),
                    ),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Sign Up page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()), // Fixed navigation
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      minimumSize: Size(200, 60),
                    ),
                    child: Text(
                      'Sign Up',
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
              width: MediaQuery.of(context).size.width * 1.5,
              height: MediaQuery.of(context).size.height * .45,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(MediaQuery.of(context).size.height),
                ),
              ),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1.5,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to Emergency page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => IndexPage()), // Fixed navigation
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      minimumSize: Size(200,MediaQuery.of(context).size.height * .45),
                      backgroundColor: Colors.red,
                      elevation: 0,
                    ),
                    child: Text(
                      'Emergency',
                      style: TextStyle(
                        fontSize: 45,
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

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://uryheuyjtmmesljjnjyt.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVyeWhldXlqdG1tZXNsampuanl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM1NTk3MzUsImV4cCI6MjA0OTEzNTczNX0.7EtxddYygjTPy167L12v0eQ7WuS4JJKhvoOo70QrBK0',
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.blue,
      colorScheme: ColorScheme.light(
        primary: Colors.blue,
        secondary: Colors.green,
      ),
    ),
    home: DirectorPage(), // DirectorPage is now the entry point
  ));
}
