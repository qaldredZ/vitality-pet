import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyScreen(),
    );
  }
}

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  int steps = 0;
  String status = 'unknown';
  late StreamSubscription<StepCount> _stepSubscription;
  late StreamSubscription<PedestrianStatus> _statusSubscription;

  @override
  void initState() {
    super.initState();
    _requestPermissionAndStart();
  }

  Future<void> _requestPermissionAndStart() async {
    await Permission.activityRecognition.request();
    _startTracking();
  }

  void _startTracking() {
    _stepSubscription = Pedometer.stepCountStream.listen(
          (StepCount event) {
        setState(() => steps = event.steps);
      },
      onError: (_) => setState(() => steps = 0),
    );

    _statusSubscription = Pedometer.pedestrianStatusStream.listen(
          (PedestrianStatus event) {
        setState(() => status = event.status);
      },
      onError: (_) => setState(() => status = 'unknown'),
    );
  }

  @override
  void dispose() {
    _stepSubscription.cancel();
    _statusSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC6D7B3),
      body: Stack(
        children: [

          // Progress bar pinned at the very top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Container(
                color: const Color(0xFFC6D7B3),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: MilestoneProgressBar(
                  currentValue: steps.toDouble() + 2000,
                  milestones: const [0, 2000, 20000, 35000, 50000],
                ),
              ),
            ),
          ),

          // Cat SVG
          Positioned(
            top: 185,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/cat.svg',
              height: 134,
              width: 141,
              placeholderBuilder: (context) => const CircularProgressIndicator(),
            ),
          ),

          // Health Bar
          Positioned(
            top: 90,
            left: 30,
            child: const VerticalHealthBar(percentage: 0.7),
          ),

          // Bottom sheet
          Positioned(
            top: 390,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF5F0E8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 5),

                      // Steps today pill
                      Container(
                        width: 171,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: Color(0xFFC6D7B3),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(32),
                            bottomLeft: Radius.circular(32),
                          ),
                        ),
                        child: const Center(
                          child: Text('Steps today', style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )),
                        ),
                      ),

                      const SizedBox(height: 5),

                      // Step count display
                      Container(
                        width: 147,
                        height: 52,
                        decoration: const BoxDecoration(
                          color: Color(0xFFC6D7B3),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(32),
                            bottomLeft: Radius.circular(32),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 9),
                            Text(
                              '$steps',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Status card
                      Container(
                        width: 360,
                        height: 106,
                        margin: const EdgeInsets.symmetric(horizontal: 18),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'pets mood will appear here',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Do your daily goals to maintain your energy',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF888888),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Daily goal card
                      Container(
                        width: 360,
                        height: 106,
                        margin: const EdgeInsets.symmetric(horizontal: 18),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Daily Goal: $steps/5000 Steps.',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Please complete your daily goals to earn rewards!',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF888888),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24, bottom: 24),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC6D7B3),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/mdi_cards.svg',
                                    width: 28,
                                    height: 28,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),

                  // CoinDisplay pinned to upper right of bottom sheet
                  const Positioned(
                    top: 12,
                    right: 16,
                    child: CoinDisplay(amount: 100),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class VerticalHealthBar extends StatelessWidget {
  final double percentage;

  const VerticalHealthBar({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    final bool isHappy = percentage > 0.5;
    final Color barColor = isHappy ? const Color(0xFF81C784) : const Color(0xFFE57373);
    final String emoji = isHappy ? '😊' : '😢';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 5),
        Container(
          width: 35,
          height: 235,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xFF454135), width: 4),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                width: double.infinity,
                height: (235 * percentage).clamp(0.0, 235.0),
                decoration: BoxDecoration(
                  color: barColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MilestoneProgressBar extends StatelessWidget {
  final double currentValue;
  final List<double> milestones;

  const MilestoneProgressBar({
    super.key,
    required this.currentValue,
    this.milestones = const [0, 2000, 20000, 35000, 50000],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTrack(),
          const SizedBox(height: 10),
          _buildLabels(),
        ],
      ),
    );
  }

  Widget _buildTrack() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double totalWidth = constraints.maxWidth;
        final int count = milestones.length;
        const double circleSize = 28.0;
        final double spacing = (totalWidth - circleSize) / (count - 1);

        return SizedBox(
          height: circleSize,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Center(
                child: Container(
                  height: 4,
                  width: totalWidth - circleSize,
                  margin: EdgeInsets.symmetric(horizontal: circleSize / 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              if (currentValue > milestones.first)
                Positioned(
                  left: circleSize / 2,
                  child: Container(
                    height: 4,
                    width: _progressWidth(totalWidth, circleSize),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8DC63F),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ...List.generate(count, (i) {
                final bool isCompleted = currentValue >= milestones[i];
                return Positioned(
                  left: i * spacing,
                  child: _MilestoneCircle(size: circleSize, isCompleted: isCompleted),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  double _progressWidth(double totalWidth, double circleSize) {
    final double max = milestones.last;
    final double min = milestones.first;
    final double clampedValue = currentValue.clamp(min, max);
    final double ratio = (clampedValue - min) / (max - min);
    return (totalWidth - circleSize) * ratio;
  }

  Widget _buildLabels() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: milestones.map((m) {
        final bool isCompleted = currentValue >= m;
        return Text(
          _formatLabel(m),
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isCompleted ? const Color(0xFF5A7A1A) : const Color(0xFF9E9E9E),
          ),
        );
      }).toList(),
    );
  }

  String _formatLabel(double value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(value % 1000 == 0 ? 0 : 1)}k';
    }
    return value.toInt().toString();
  }
}

class _MilestoneCircle extends StatelessWidget {
  final double size;
  final bool isCompleted;

  const _MilestoneCircle({required this.size, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted ? const Color(0xFF8DC63F) : const Color(0xFFCCCBCB),
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: isCompleted
            ? [BoxShadow(
          color: const Color(0xFF8DC63F).withOpacity(0.4),
          blurRadius: 6,
          spreadRadius: 1,
        )]
            : null,
      ),
      child: isCompleted
          ? const Icon(Icons.check, color: Colors.white, size: 16)
          : null,
    );
  }
}

class CoinDisplay extends StatelessWidget {
  final int amount;

  const CoinDisplay({
    super.key,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCF1),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.savings_rounded,
            color: Color(0xFF000000),
            size: 28,
          ),
          const SizedBox(width: 6),
          Text(
            '$amount',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF3D3519),
            ),
          ),
        ],
      ),
    );
  }
}
