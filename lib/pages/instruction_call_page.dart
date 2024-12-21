import 'package:flutter/material.dart';


/// This class is created for instruction & call page that user
/// should interact with (in case of emergency situation without sign in)
// Instruction and Video Call Page
class InstructionPage extends StatefulWidget 
{
  const InstructionPage({super.key});
  
  @override
  State<InstructionPage> createState() => _InstructionPageState();
}

class _InstructionPageState extends State<InstructionPage> {
  final List<String> emergencyCases = [
    'Heart Attack',
    'Stroke',
    'Choking',
    'Burn Injury'
  ];
  String? selectedCase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Instructions'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Select Emergency Case:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedCase,
              items: emergencyCases.map((caseName) {
                return DropdownMenuItem(
                  value: caseName,
                  child: Text(caseName),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCase = value;
                });
              },
              hint: Text('Choose a case'),
            ),
          ],
        ),
      ),
    );
  }
}
