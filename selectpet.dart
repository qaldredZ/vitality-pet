import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:fluttervitalityapp/cat.dart';
void main() {
  runApp(const VitalityPetApp());
}

class VitalityPetApp extends StatelessWidget {
  const VitalityPetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vitality Pet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFE8E4C8),
      ),
      home: const PetSelectionScreen(),
    );
  }
}



class PetData {
  final String emoji;
  final String name;
  const PetData({required this.emoji, required this.name});
}



class PetSelectionScreen extends StatefulWidget {
  const PetSelectionScreen({super.key});

  @override
  State<PetSelectionScreen> createState() => _PetSelectionScreenState();
}

class _PetSelectionScreenState extends State<PetSelectionScreen> {
  final int maxSelection = 3;

  final List<PetData> pets = const [
    PetData(emoji: '🐱', name: 'Cat'),
    PetData(emoji: '🐶', name: 'Dog'),
    PetData(emoji: '🐰', name: 'Rabbit'),
    PetData(emoji: '🐷', name: 'Pig'),
    PetData(emoji: '🐦', name: 'Bird'),
  ];

  final Set<int> selectedIndices = {};

  void _toggleSelection(int index) {
    setState(() {
      if (selectedIndices.contains(index)) {
        selectedIndices.remove(index);
      } else {
        if (selectedIndices.length < maxSelection) {
          selectedIndices.add(index);
        }
      }
    });
  }

  void _onConfirm() {
    final selected = selectedIndices.map((i) => pets[i]).toList();
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, animation, __) =>
            EggHatchScreen(selectedPets: selected),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E4C8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              const Spacer(flex: 2),
              const Text(
                'Pet Selection',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2C2C2C),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Select $maxSelection out of ${pets.length} pets you want.\nYou may only get 1 pet for each account.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF666666),
                  height: 1.5,
                ),
              ),
              const Spacer(flex: 2),
              _buildPetGrid(),
              const Spacer(flex: 3),
              _buildConfirmButton(),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPetGrid() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 3; i++) ...[
              _PetCard(
                pet: pets[i],
                isSelected: selectedIndices.contains(i),
                onTap: () => _toggleSelection(i),
              ),
              if (i < 2) const SizedBox(width: 16),
            ],
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 3; i < 5; i++) ...[
              _PetCard(
                pet: pets[i],
                isSelected: selectedIndices.contains(i),
                onTap: () => _toggleSelection(i),
              ),
              if (i < 4) const SizedBox(width: 16),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    final bool isEnabled = selectedIndices.isNotEmpty;
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: isEnabled ? _onConfirm : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7A8C5A),
          disabledBackgroundColor: const Color(0xFF7A8C5A).withOpacity(0.5),
          foregroundColor: const Color(0xFFE8E4C8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check, size: 18, color: Color(0xFFE8E4C8)),
            SizedBox(width: 8),
            Text(
              'Confirm Pet',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PetCard extends StatelessWidget {
  final PetData pet;
  final bool isSelected;
  final VoidCallback onTap;

  const _PetCard({
    required this.pet,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF7A8C5A)
                : const Color(0xFFD4CEB8),
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Text(pet.emoji, style: const TextStyle(fontSize: 44)),
            ),
            if (isSelected)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFF7A8C5A),
                    shape: BoxShape.circle,
                  ),
                  child:
                  const Icon(Icons.check, size: 13, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}



class EggHatchScreen extends StatefulWidget {
  final List<PetData> selectedPets;
  const EggHatchScreen({super.key, required this.selectedPets});

  @override
  State<EggHatchScreen> createState() => _EggHatchScreenState();
}

class _EggHatchScreenState extends State<EggHatchScreen>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _wobbleController;
  late Animation<double> _floatAnimation;
  late Animation<double> _wobbleAnimation;

  final int currentXP = 2000;
  final int maxXP = 2000;

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _wobbleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );

    _wobbleAnimation = Tween<double>(begin: -0.06, end: 0.06).animate(
      CurvedAnimation(parent: _wobbleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    _wobbleController.dispose();
    super.dispose();
  }

  Future<void> _onHatch() async {
    // Quick shake animation x3
    for (int i = 0; i < 3; i++) {
      await _wobbleController.forward();
      await _wobbleController.reverse();
    }
    _wobbleController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E4C8),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),

            // Floating + wobbling egg
            AnimatedBuilder(
              animation:
              Listenable.merge([_floatController, _wobbleController]),
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _floatAnimation.value),
                  child: Transform.rotate(
                    angle: _wobbleAnimation.value,
                    child: child,
                  ),
                );
              },
              child: const _EggWidget(),
            ),

            const SizedBox(height: 36),

            // XP pill
            _buildXpPill(),

            const Spacer(flex: 3),

            // Hatch button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: _buildHatchButton(),
            ),

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildXpPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF4A4A3A),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        '$currentXP/$maxXP',
        style: const TextStyle(
          color: Color(0xFFE8E4C8),
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildHatchButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7A8C5A),
          foregroundColor: const Color(0xFFE8E4C8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Hatch now!',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}



class _EggWidget extends StatelessWidget {
  const _EggWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 250,
      child: CustomPaint(painter: _EggPainter()),
    );
  }
}

class _EggPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;

    // Grass shadow
    final grassPaint = Paint()..color = const Color(0xFF8FA85A);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, size.height - 12),
        width: 120,
        height: 20,
      ),
      grassPaint,
    );

    // Egg body gradient
    final eggRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final eggPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF706835), Color(0xFF3E3818)],
      ).createShader(eggRect);

    canvas.drawPath(_eggPath(size), eggPaint);

    // Highlight on top-left
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx - 22, size.height * 0.25),
        width: 55,
        height: 40,
      ),
      highlightPaint,
    );

    // Crack spots
    _drawSpot(canvas, cx - 30, size.height * 0.30, 30, 22, -0.35);
    _drawSpot(canvas, cx + 12, size.height * 0.42, 34, 26, 0.18);
    _drawSpot(canvas, cx - 16, size.height * 0.56, 26, 20, -0.08);
  }

  Path _eggPath(Size size) {
    final w = size.width * 0.70;
    final cx = size.width / 2;
    final top = size.height * 0.04;
    final bottom = size.height - 18.0;
    final h = bottom - top;

    return Path()
      ..moveTo(cx, top)
      ..cubicTo(cx + w * 0.55, top, cx + w * 0.5, top + h * 0.62, cx, bottom)
      ..cubicTo(cx - w * 0.5, top + h * 0.62, cx - w * 0.55, top, cx, top)
      ..close();
  }

  void _drawSpot(
      Canvas canvas, double x, double y, double w, double h, double angle) {
    final paint = Paint()..color = const Color(0xFFE8E4C8).withOpacity(0.82);
    canvas.save();
    canvas.translate(x, y);
    canvas.rotate(angle);
    final path = Path()
      ..moveTo(0, -h / 2)
      ..cubicTo(w / 2, -h / 2, w / 2, h * 0.28, 0, h / 2)
      ..cubicTo(-w / 2, h * 0.28, -w / 2, -h / 2, 0, -h / 2)
      ..close();
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
