import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import  'package:fluttervitalityapp/signup.dart';
import 'package:fluttervitalityapp/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = true;
  bool _isPasswordVisible = false; // Added to control password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E5C9),
      body: Stack(
        children: [
          ClipPath(
            clipper: WavyHeaderClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.20,
              width: double.infinity,
              color: const Color(0xFF8D9758),
            ),
          ),
          Positioned(
            top: 50,
            left: 15,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFFE9E5C9)),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => OpeningScreen()),
                      (Route<dynamic> route) =>
                  false, // This clears the entire history stack
                );
              },
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                  Text(
                    'Login',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF454135),
                    ),
                  ),
                  const SizedBox(height: 35),
                  _buildTextField(
                    hint: 'Email Address',
                    icon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 18),
                  _buildTextField(
                    hint: 'Password',
                    icon: Icons.lock_outlined,
                    isPassword: true,
                    isPasswordVisible: _isPasswordVisible,
                    onToggleVisibility: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            activeColor: const Color(0xFF433D35),
                            onChanged: (val) =>
                                setState(() => _rememberMe = val!),
                          ),
                          const Text(
                            'Remember me',
                            style: TextStyle(
                              color: Color(0xFF536E44),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: Color(0xFF3D7268),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF433D35),
                        shape: const StadiumBorder(),
                        elevation: 4,
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFFE9E5C9),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Color(0xFF536E44),
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign up',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onToggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF8D9758),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        obscureText: isPassword && !isPasswordVisible,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: const Color(0xB8000000), size: 20),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: const Color(0xFF433D35),
            ),
            onPressed: onToggleVisibility,
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
