import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/features/auth/screens/register.dart';
import 'package:health_and_doctor_appointment/features/auth/screens/signIn.dart';

class AuthWelcomeScreen extends StatefulWidget {
  const AuthWelcomeScreen({Key? key}) : super(key: key);

  @override
  _FireBaseAuthState createState() => _FireBaseAuthState();
}

class _FireBaseAuthState extends State<AuthWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Subtle Background Elements (Optional decorative circles)
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.indigo.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),

                  // 2. Main Title & Branding
                  Text(
                    'HELLO',
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 50,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'Welcome to HealthBridge!',
                    style: GoogleFonts.lato(
                      color: Colors.indigo[800],
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Your health is our priority. Sign in to start your journey with top-rated doctors.',
                    style: GoogleFonts.lato(
                      color: Colors.grey[500],
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),

                  const Spacer(),

                  // 3. Action Section
                  _buildActionButton(
                    text: "Sign In",
                    isPrimary: true,
                    onTap: () => _pushPage(context, SignIn()),
                  ),
                  const SizedBox(height: 20),
                  _buildActionButton(
                    text: "Create an Account",
                    isPrimary: false,
                    onTap: () => _pushPage(context, Register()),
                  ),

                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- UI Helper for Buttons ---
  Widget _buildActionButton({
    required String text,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? Colors.indigo[900] : Colors.white,
          foregroundColor: isPrimary ? Colors.white : Colors.indigo[900],
          elevation: isPrimary ? 5 : 0,
          shadowColor: Colors.indigo.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: isPrimary ? BorderSide.none : BorderSide(color: Colors.indigo[100]!, width: 2),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}