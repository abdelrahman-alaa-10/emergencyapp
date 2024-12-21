import 'package:flutter/material.dart';
import 'pages/signIn.dart';  // Correct import for SignInPage
import 'pages/signUp.dart';  // Correct import for SignUpPage
import 'pages/callPage.dart';  // Correct import for CallPage
import 'routes.dart';
import 'pages/videocall.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Emergency App',
    theme: ThemeData(
      primaryColor: Colors.blue,
      colorScheme: const ColorScheme.light(
        primary: Colors.blue,
        secondary: Colors.green,
      ),
      useMaterial3: true
    ),
    home: const HomeScreen(),
    routes:
    {
      Routes.videoCallRoute: (context) => const VideoCall(),
    }
    );
  }
}

class HomeScreen extends StatelessWidget
{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Emergency Call
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, Routes.videoCallRoute);
              }, child: const Text("Emergency Call"),
            ),
            // Specialist Button
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, Routes.specialistPageRoute);
              }, child: const Text("I am a Doctor"),
            ),
            // Instructions Button
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, Routes.instructionsRoute);
              }, child: const Text("Emergency Instructions"),
            )
          ],
        ),
      ),
    );
  }
}
