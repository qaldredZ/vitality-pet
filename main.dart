import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttervitalityapp/login.dart';
import  'package:fluttervitalityapp/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
      home: const OpeningScreen(),
    );
  }
}

class OpeningScreen extends StatelessWidget {
  const OpeningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8D9758),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 480),
            const ButtonTypesGroup(
              text: "Login",
              backgroundColor: Color(0xFF433D35),
              textColor: Color(0xFFF1E9D2),
            ),
            const SizedBox(height: 16),
            const ButtonTypesGroup(
              text: "Sign up",
              backgroundColor: Color(0xFFF1E9D2),
              textColor: Color(0xFF433D35),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonTypesGroup extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const ButtonTypesGroup({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    const double circleDim = 42.0;
    const double btnWidth = 233.0;
    const double btnHeight = 46.0;

    return SizedBox(
      width: btnWidth,
      height: btnHeight,
      child: ElevatedButton(
        onPressed: () {
          if (text == "Login") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          } else if (text == "Sign up") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupScreen()),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 2),
        ),
        child: Row(
          children: [
            const Opacity(
              opacity: 0,
              child: SizedBox(width: circleDim, height: circleDim),
            ),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: circleDim,
              height: circleDim,
              decoration: BoxDecoration(
                color: textColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(Icons.pets, color: backgroundColor, size: 27),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
