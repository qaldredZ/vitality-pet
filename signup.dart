import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group3hci/main.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Logic for the two eye icons
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E5C9), // Light cream
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            // Forces the Stack to be at least as tall as the screen
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Stack(
                children: [
                  // 1. BACKGROUND LAYER: THE WAVE
                  ClipPath(
                    clipper: WavyHeaderClipper(),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: double.infinity,
                      color: const Color(0xFF8D9758), // Olive green
                    ),
                  ),

                  // 2. FORM CONTENT LAYER
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ADJUSTED: Changed from 0.35 to 0.18 so the text is visible
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.26,
                        ),

                        Text(
                          'Sign up',
                          style: GoogleFonts.inter(
                            fontSize: 24, // Larger size for visibility
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF454135), // Dark brown
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Email Field
                        _buildTextField(
                          hint: 'Email Address',
                          icon: Icons.email_outlined,
                        ),

                        const SizedBox(height: 18),

                        // Password Field
                        _buildTextField(
                          hint: 'Password',
                          icon: Icons.lock_outlined,
                          isPassword: true,
                          obscureText: _obscurePassword,
                          onEyePressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Confirm Password Field
                        _buildTextField(
                          hint: 'Confirm Password',
                          icon: Icons.lock_outlined,
                          isPassword: true,
                          obscureText: _obscureConfirmPassword,
                          onEyePressed: () => setState(
                            () => _obscureConfirmPassword =
                                !_obscureConfirmPassword,
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Sign up Button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {
                              // Sign up logic goes here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF433D35),
                              shape: const StadiumBorder(),
                              elevation: 4,
                            ),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                color: Color(0xFFE9E5C9),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),

                        // Already have an account?
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account? ",
                                style: TextStyle(
                                  color: Color(0xFF536E44),
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: const Text(
                                  'Sign in',
                                  style: TextStyle(
                                    color: Color(0xFF536E44),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),

                  // 3. BACK BUTTON LAYER (Top-most layer)
                  Positioned(
                    top: 50,
                    left: 15,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFFE9E5C9),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => OpeningScreen(),
                          ),
                          (Route<dynamic> route) =>
                              false, // This clears the entire history stack
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Reusable TextField helper
  Widget _buildTextField({
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onEyePressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF8D9758), // Olive green
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        obscureText: isPassword ? obscureText : false,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: const Color(0xFF433D35), size: 20),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: const Color(0xFF433D35),
                  ),
                  onPressed: onEyePressed,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
        ),
      ),
    );
  }
}

// Wave Clipper (Keep this outside the _SignupScreenState class)
class WavyHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.75);
    var firstControlPoint = Offset(size.width * 0.35, size.height * 1.05);
    var firstEndPoint = Offset(size.width * 0.6, size.height * 0.85);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    var secondControlPoint = Offset(size.width * 0.85, size.height * 0.65);
    var secondEndPoint = Offset(size.width, size.height * 0.8);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
