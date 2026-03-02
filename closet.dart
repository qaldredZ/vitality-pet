import 'package:flutter/material.dart';

void main() => runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false, 
        home: GameDressingRoom(),
      ),
    );

class GameDressingRoom extends StatelessWidget {
  const GameDressingRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB1BC8E), // Sage green background
      body: SafeArea(
        child: Column(
          children: [
            // --- TOP SECTION: Header ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios_new, size: 24),
                  const SizedBox(width: 10),
                  const Text(
                    "Dressing room",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            // --- MIDDLE SECTION: Character ---
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Character Image/Icon
                  const Icon(Icons.pets, size: 100, color: Color(0xFF4A453C)),
                  const SizedBox(height: 10),
                  const Text(
                    "BROWNY",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // --- BOTTOM SECTION: The Dressing Room Grid ---
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF2EBD1), // Cream background from image
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Tabs and Currency Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          _buildTabToggle(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: _buildCurrencyBadge("100"),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: _buildClothingGrid()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // UI Helper for the Dressing Room Tabs (Shirt and Hat icons)
  Widget _buildTabToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFC7C7B5),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _tabIcon(Icons.checkroom, isSelected: true),
          _tabIcon(Icons.theater_comedy, isSelected: false),
        ],
      ),
    );
  }

  Widget _tabIcon(IconData icon, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF4A453C) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        icon, 
        color: isSelected ? Colors.white : const Color(0xFF4A453C), 
        size: 22
      ),
    );
  }

  // Currency Badge (Top right of the cream container)
  Widget _buildCurrencyBadge(String amount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.monetization_on, size: 16, color: Colors.grey),
          const SizedBox(width: 4),
          Text(
            amount,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ],
      ),
    );
  }

  // The 3x3 Clothing Grid
  Widget _buildClothingGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(25),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF4A453C), width: 4),
          ),
          child: index < 6 
            ? Icon(Icons.dry_cleaning, color: Colors.pink[200], size: 45)
            : null, // Empty boxes for the bottom row
        );
      },
    );
  }
}
