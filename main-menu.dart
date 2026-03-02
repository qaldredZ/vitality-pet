adddadasdwadsimport 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PetStepScreen(),
    );
  }
}

class PetStepScreen extends StatelessWidget {
  const PetStepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9CFAF),
      body: SafeArea(
        child: Column(
          children: [
            // yung green sa taas
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFA9B88E),
              ),
              child: Column(
                children: [
                  // indicator ng steps shits
                  Row(
                    children: const [
                      Expanded(child: StepCircle(label: "0", active: true)),
                      StepLine(active: true),
                      Expanded(child: StepCircle(label: "2000", active: true)),
                      StepLine(active: false),
                      Expanded(child: StepCircle(label: "20000", active: false)),
                      StepLine(active: false),
                      Expanded(child: StepCircle(label: "35000", active: false)),
                      StepLine(active: false),
                      Expanded(child: StepCircle(label: "50000", active: false)),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //yung pa angat na bar
                      Container(
                        height: 160,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 2),
                          color: Colors.white,
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.lime,
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),

                      // pussy pic
                      Image.asset(
                        "lalagay aso dito",
                        height: 120,
                      ),

                      const Spacer(),

                      // Settings Icon
                      IconButton(
                        icon: const Icon(Icons.settings, size: 28),
                        onPressed: () {
                          print("Settings pressed");
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "browny basta yung aso",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Steps
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC7D1B2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Steps today",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB5C4A2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Text(
                      "2000",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // CARD ng mood
            const InfoCard(
              title: "Browny is feeling Vibrant!",
              subtitle:
                  "Do your daily goals to maintain your pet’s energy",
            ),

            const SizedBox(height: 15),

            // CARD ng goals
            const InfoCard(
              title: "Daily Goal: 2000/5000 Steps",
              subtitle:
                  "Please complete your daily goals to earn rewards!",
            ),
          ],
        ),
      ),
    );
  }
}

class StepCircle extends StatelessWidget {
  final String label;
  final bool active;

  const StepCircle({super.key, required this.label, required this.active});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? Colors.green : Colors.grey.shade300,
          ),
          child: active
              ? const Icon(Icons.check, size: 16, color: Colors.white)
              : null,
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}

class StepLine extends StatelessWidget {
  final bool active;

  const StepLine({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 3,
        color: active ? Colors.green : Colors.grey.shade400,
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const InfoCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          print("Card pressed");
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black12,
                offset: Offset(0, 5),
              )
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Image.asset(
                "picture ng aso",
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

