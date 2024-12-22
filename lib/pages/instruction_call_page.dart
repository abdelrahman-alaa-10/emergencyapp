import 'package:flutter/material.dart';

class InstructionPage extends StatefulWidget {
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

  final List<List<Map<String, String>>> emergencyFirstAidInstructions = [
    // Heart Attack
    [
      {
        'text': 'Symptoms: Chest pain, shortness of breath, sweating, nausea, and pain radiating to the arm, neck, or jaw.'
      },
      {
        'text': '1. Have the person sit down and rest in a comfortable position.',
        'image': 'lib/pages/assets/images/heart/1.jpeg'
      },
      {
        'text': '2. Encourage the person to chew an aspirin (unless allergic).',
        'image': 'lib/pages/assets/images/heart/2.png'
      },
    ],

    // Stroke
    [
      {
        'text': 'Symptoms: Sudden numbness or weakness, confusion, trouble speaking, vision problems, or severe headache.',
      },
      {
        'text': '1. Keep the person in a comfortable position.',
        'image': 'lib/pages/assets/images/stroke/1.jpg'
      },
      {
        'text': '2. Do not offer any food or drink.',
        'image': 'lib/pages/assets/images/stroke/2.png'
      },
    ],

    // Choking
    [
      {
        'text': 'Symptoms: Difficulty breathing, coughing, wheezing, or inability to speak.'
      },
      {
        'text': '1. Encourage coughing, as it might help expel the object.',
        'image': 'lib/pages/assets/images/choking/1.jpeg'
      },
      {
        'text': '2. If coughing fails, perform the Heimlich maneuver steps [SWIPE].',
      },
      {
        'text': '3. Stand behind the person and wrap your arms around their waist.',
        'image': 'lib/pages/assets/images/choking/2.png'
      },
      {
        'text': '4. Make a fist with one hand and place it slightly above their navel.',
        'image': 'lib/pages/assets/images/choking/3.png'
      },
      {
        'text': '5. Grasp the fist with your other hand and press inward and upward with quick thrusts.',
        'image': 'lib/pages/assets/images/choking/4.png'
      },
      {
        'text': '6. REPEAT thrusts until the object is expelled or the person becomes unresponsive.'
      },
      {
        'text': '7. If the person becomes unresponsive,  START CPR if trained.',
        'image': 'lib/pages/assets/images/choking/5.png'
      }
    ],

    // Burn Injury
    [
      {
        'text': 'Symptoms: Redness, blisters, or pain at the burn site.'
      },
      {
        'text': '1. Cool the burn with running water for at least 10 minutes.',
        'image': 'lib/pages/assets/images/burn/1.png'
      },
      {
        'text': '2. Cover the burn with a sterile bandage or cloth.',
        'image': 'lib/pages/assets/images/burn/2.png'
      },
    ]
  ];

  String? selectedCase;
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int? selectedIndex = selectedCase != null
        ? emergencyCases.indexOf(selectedCase!)
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Instructions'),
        backgroundColor: Colors.blue,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.blue,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select Emergency Case:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // White background for dropdown
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: Colors.white, // Dropdown menu background
                  isExpanded: true,
                  value: selectedCase,
                  items: emergencyCases.map((caseName) {
                    return DropdownMenuItem(
                      value: caseName,
                      child: Text(
                        caseName,
                        style: TextStyle(color: Colors.blue), // Text color
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCase = value;
                      currentIndex = 0;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_pageController.hasClients) {
                          _pageController.jumpToPage(currentIndex);
                        }
                      });
                    });
                  },
                  hint: Text(
                    'Choose a case',
                    style: TextStyle(color: Colors.grey), // Hint text color
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            if (selectedIndex != null)
              Expanded(
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount:
                      emergencyFirstAidInstructions[selectedIndex].length,
                      itemBuilder: (context, index) {
                        final step =
                        emergencyFirstAidInstructions[selectedIndex][index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (step['image'] != null)
                                Image.asset(
                                  step['image']!,
                                  height: 400,
                                  width: 300,
                                  fit: BoxFit.fill,
                                ),
                              SizedBox(height: 20),
                              Text(
                                step['text']!,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                    Positioned(
                      left: 10,
                      top: MediaQuery.of(context).size.height * 0.5 - 30,
                      child: IconButton(
                        icon: Icon(Icons.arrow_left,
                            size: 30, color: Colors.white),
                        onPressed: currentIndex > 0
                            ? () {
                          _pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                            : null,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: MediaQuery.of(context).size.height * 0.5 - 30,
                      child: IconButton(
                        icon: Icon(Icons.arrow_right,
                            size: 30, color: Colors.white),
                        onPressed: currentIndex <
                            emergencyFirstAidInstructions[selectedIndex]
                                .length -
                                1
                            ? () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
