import 'package:emergencyapp/pages/instruction_call_page.dart';
import 'package:flutter/material.dart';
import 'videocallindex.dart';

class UserPage extends StatelessWidget {
  final String userName;

  // Constructor to accept the userName parameter
  const UserPage({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 50,
              bottom: MediaQuery.of(context).size.height * .35 + 50,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'InstaCall',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Quick Help. Anytime. Anywhere.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 10),
                  Text(
                    'Welcome, $userName!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 50),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                InstructionPage()), // Fixed navigation
                      );
                    },
                    child: Text('Instructions'),
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
